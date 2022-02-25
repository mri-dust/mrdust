module fsm #(
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
	reg [3:0] ns; // register holding current state

	reg [9:0] counter1; // counter1
	reg count1; // counter1 indicator
	reg [4:0] counter2; // counter2
	reg count2; // counter2 indicator
	reg [3:0] dataStorage;
	reg [1:0] shift; 

	reg positiveCurrent;
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
			positiveCurrent <= 1'b1;
		end else begin
			cs <= ns;
			if (count1 && count2) begin
				counter2 <= counter2 - 1'b1;
			end else if (count1) begin
				counter1 <= counter1 + 1'b1;
			end else if (count2) begin
				counter2 <= counter2 + 1'b1; 
			end
		end
	end

	always @(*) begin
		case (cs)
			Reset: begin
				if (dataBit) begin
					ns = Edge1;
					counter1 = 10'b0;
				end else begin
					ns = Reset;
				end
			end

			Edge1: begin
				count1 = 1;
				if (counter1 > TIMEOUT) ns = Reset;
				else if (dataBit) begin
					ns = Edge2;
					counter1 = 0;
					count1 = 0; // need to shut off the counting untill we have transitioned to the next state
				end else begin
					ns = Edge1;
				end
			end
			
			Edge2: begin
				count1 = 1;
				if (counter1 > TIMEOUT) ns = Reset;
				else if (dataBit) begin
					ns = DataIn;
					counter1 = 0;
					count1 = 0; 
				end else begin
					ns = Edge2;
				end
			end

			DataIn: begin
				// waiting for signal to start metadata transfer
				if (dataBit) begin
					ns = Adding;
					counter2 = 5'b01111;
				end else ns = DataIn;
				dataStorage = 0;
				shift = 2'b11;
			end

			Adding: begin
				count2 = 1;
				if (dataBit) ns = Subtracting;
				else begin
					ns = Adding;
				end
			end

			Subtracting: begin
				count1 = 1;
				// since both count0 and count1 are high now, should be subtracting from counter2
				if (dataBit) ns = EndBit;
				else ns = Subtracting;
			end

			EndBit: begin
				count1 = 0;
				count2 = 0;
				dataStorage[shift] = counter2[4];	
				// here we wait for another pulse to initiate either the next bit transmission or continue to the next segment
				if (dataBit) begin
					if (shift == 2'd0) begin
						ns = WaitScan;
						shift = 2'b11;
					end
					else begin
						counter2 = 5'b01111;
						shift = shift - 1;
						ns = Adding;
					end
				end
			end

			WaitScan: begin
				if (dataBit) ns = SendPos;
				else ns = WaitScan;
			end

			SendPos: begin
				// currently because the device does not leave these two last states (only oscillates between them, there is no need to unset amplitude afterwards.
				positiveCurrent = 1;
				amplitude = dataStorage;
				if (dataBit) ns = SendNeg;
				else ns = SendPos;
			end

			SendNeg: begin
				positiveCurrent = 0;
				if (dataBit) ns = SendPos;
				else ns = SendNeg;
			end

			default: ns = Reset;
		endcase
	end

	// wire up the green LED to be always on
	assign GLED5 = positiveCurrent;
	// wire up the red LEDs to the counter
	assign RLED1 = amplitude[0];
	assign RLED2 = amplitude[1];
	assign RLED3 = amplitude[2];
	assign RLED4 = amplitude[3];

endmodule
