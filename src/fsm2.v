module fsm2 #(
	parameter TIMEOUT = 1000
) (
	input CLK_IN, 
	input DATA_IN,
	input rst,
	output GLED5, 
	output RLED1, 
	output RLED2, 
	output RLED3, 
	output RLED4,
	output reg [3:0] amplitude
);
	localparam 
		// initialization sequence
		Reset = 0, // waiting for the first edge
		Edge1 = 1, // waiting for the second edge
		Edge2 = 2, // waiting for the third edge

		// collecting metadata
		DataIn = 3, // waiting for another edge to start the transmission of a bit.
		Adding = 4, // adding to the bit accumulation counter until edge
		Subtracting = 5, // subtracting from the bit accumulation until edge
		EndBit = 6, // push databit to shift register. if full, move to scan, else repeat.

		// scan period
		WaitScan = 7, // wait for a posedge to start the scan
		SendPos = 8, // sending positive current through the loop (indicated by single bit.)
		SendNeg = 9; // sending negative current through the loop 

	reg [3:0] cs; // register holding current state

	reg [9:0] counter1; // counter1
	reg [4:0] counter2; // counter2
	reg [3:0] dataStorage;
	reg [1:0] shift; // TODO: I think in the future, this could be just made 4 bits and we could just shift a selector bit because the shift hardware takes less space than addition.

	reg positiveCurrent;
	reg [10:0] supCounter;
	reg supportPulse;

	wire dataBit;

	edge_detector detect (
		.clk(CLK_IN),
		.dataIn(DATA_IN),
		.rst(rst),
		.dataOut(dataBit)
	);

	always @(posedge CLK_IN) begin
		if (rst) begin
			cs <= 4'b0;
			counter1 <= 10'b0;
			counter2 <= 5'b0;
			dataStorage <= 4'b0;
			shift <= 2'b11;
			amplitude <= 4'b0;
			positiveCurrent <= 1;
		end else begin
			case (cs)
				Reset: begin
					if (dataBit) begin
						cs <= Edge1;
						counter1 <= 10'b0;
					end else begin
						cs <= Reset;
					end
				end

				Edge1: begin
					counter1 <= counter1 + 1; // count up to TIMEOUT
					if (counter1 > TIMEOUT) cs <= Reset;
					else if (dataBit) begin
						cs <= Edge2;
						counter1 = 0;
					end else begin
						cs <= Edge1;
					end
				end
				
				Edge2: begin
					counter1 <= counter1 + 1; // count up to TIMEOUT
					if (counter1 > TIMEOUT) cs <= Reset;
					else if (dataBit) begin
						cs <= DataIn;
						counter1 <= 0;
					end else begin
						cs <= Edge2;
					end
				end

				DataIn: begin
					// waiting for signal to start metadata transfer
					if (dataBit) begin
						cs <= Adding;
						counter2 <= 5'b01111;
					end else cs <= DataIn;
					dataStorage <= 0;
					shift <= 2'b11;
				end

				Adding: begin
					counter2 <= counter2 + 1;
					if (dataBit) cs <= Subtracting;
					else cs <= Adding;
				end

				Subtracting: begin
					counter2 <= counter2 - 1;
					if (dataBit) cs <= EndBit;
					else cs <= Subtracting;
				end

				EndBit: begin
					dataStorage[shift] <= counter2[4];	
					// here we wait for another pulse to initiate either the next bit transmission or continue to the next segment
					if (dataBit) begin
						if (shift == 2'd0) begin
							cs <= WaitScan;
							shift <= 2'b11;
						end
						else begin
							counter2 <= 5'b01111;
							shift <= shift - 1;
							cs <= Adding;
						end
					end
				end

				WaitScan: begin
					if (dataBit) cs <= SendPos;
					else cs <= WaitScan;
				end

				SendPos: begin
					// currently because the device does not leave these two last states (only oscillates between them, there is no need to unset amplitude afterwards.
					positiveCurrent <= 1;
					amplitude <= dataStorage;
					if (dataBit) cs <= SendNeg;
					else cs <= SendPos;
				end

				SendNeg: begin
					positiveCurrent <= 0;
					if (dataBit) cs <= SendPos;
					else cs <= SendNeg;
				end

				default: cs <= Reset;
			endcase
		end
	end

	// wire up the green LED to be always on
	assign GLED5 = positiveCurrent;
	// wire up the red LEDs to the counter
	assign RLED1 = amplitude[0];
	assign RLED2 = amplitude[1];
	assign RLED3 = amplitude[2];
	assign RLED4 = amplitude[3];

endmodule
