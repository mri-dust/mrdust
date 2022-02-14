module fsm (
	input CLK_IN, 
	input DATA_IN,
	input rst,
	output GLED5, 
	output RLED1, 
	output RLED2, 
	output RLED3, 
	output RLED4
);
	localparam timeout = 1000;
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
	reg [3:0] ns; // register holding next state

	reg [9:0] counter1; // counter1
	reg [4:0] counter2; // counter2
	reg [3:0] dataStorage;
	reg [1:0] shift;

	reg [10:0] millisecondCounter;
	reg millisecond;

	wire dataBit;

	edge_detector detect (
		.clk(CLK_IN),
		.dataIn(DATA_IN),
		.rst(rst),
		.dataOut(dataBit)
	);

	always @(posedge CLK_IN) begin
		if (rst) begin
			millisecondCounter <= 0;
			millisecond <= 0;
		end else if (millisecondCounter == 10000) begin
			millisecond <= 1;
			millisecondCounter <= 0;
		end else begin
			millisecond <= 0;
			millisecondCounter <= millisecondCounter + 1;
		end
	end

	always @(posedge CLK_IN) begin
		if (rst) cs <= Reset;
		else cs <= ns;
	end

	always @(posedge CLK_IN) begin
		case (cs)
			Reset: begin
				if (dataBit) begin
					ns = Edge1;
					counter1 = 0;
				end else begin
					ns = Reset;
				end
			end
			Edge1: begin
				if (millisecond) counter1 <= counter1 + 1; // count up to timeout
				if (counter1 > timeout) ns = Reset;
				else if (dataBit) begin
					ns = Edge2;
					counter1 = 0;
				end else begin
					ns = Edge1;
				end
			end
			Edge2: begin
				if (millisecond) counter1 <= counter1 + 1; // count up to timeout
				if (counter1 > timeout) ns = Reset;
				if (dataBit) begin
					ns = DataIn;
					counter1 = 0;
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
				shift = 0;
			end
			Adding: begin
				counter2 = counter2 + 1;
				if (dataBit) ns = Subtracting;
				else ns <= Adding;
			end
			Subtracting: begin
				counter2 = counter2 - 1;
				if (dataBit) ns = EndBit;
				else ns = Subtracting;
			end
			EndBit: begin
				dataStorage[shift] <= counter2[4];	
				shift <= shift + 1;
				if (shift == 2'd4) begin
					ns = WaitScan;
					shift <= 0;
				end
				else begin
					counter2 = 0;
					ns = Adding;
				end
			end
			WaitScan: begin
				if (dataBit) ns = SendPos;
				else ns = WaitScan;
			end
			SendPos: begin
				if (dataBit) ns = SendNeg;
				else ns = SendPos;
			end
			SendNeg: begin
				if (dataBit) ns = SendPos;
				else ns = SendNeg;
			end
			default:
				ns = Reset;
		endcase
	end

	// wire up the green LED to be always on
	assign GLED5 = 1'b1;
	// wire up the red LEDs to the counter
	assign RLED1 = ns[0];
	assign RLED2 = ns[1];
	assign RLED3 = ns[2];
	assign RLED4 = ns[3];

endmodule
