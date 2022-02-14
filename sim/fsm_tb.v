`timescale 1ns/1ps

module fsm_tb();
	reg clk, rst;
	localparam CLOCK_FREQ   = 125_000_000;
	localparam CLOCK_PERIOD = 1_000_000_000 / CLOCK_FREQ;

	// to spin the clock
	initial clk = 0;
	always #(CLOCK_PERIOD / 2) clk = ~clk;

	wire [4:0] led;
	reg data;

	fsm DUT (
		.rst(rst),
		.CLK_IN(clk), 
		.DATA_IN(data),
		.GLED5(led[0]), 
		.RLED1(led[1]), 
		.RLED2(led[2]), 
		.RLED3(led[3]), 
		.RLED4(led[4])
	);

	task checkState;
		input state;
		begin
			assert(DUT.cs == state) else $error("Current state is incorrect!");
		end
	endtask

	task checkDataOut;
		input truth;
		begin
			assert(DUT.dataStorage == truth) else $error("Saved data is incorrect!");
		end
	endtask

	integer i;
	task transmit0;
		begin 
			repeat (2) @(posedge clk);
			#1;
			data = 1;
			@(posedge clk);
			#1;
			data = 0;
			for (i = 0; i < 6; i = i + 1) begin
				@(posedge clk);
			end
			#1;
			data = 1;
			@(posedge clk);
			#1;
			data = 0;
		end 
	endtask

	integer j;
	task transmit1;
		begin 
			for (j = 0; j < 6; j = j + 1) begin
				@(posedge clk);
			end
			#1;
			data = 1;
			@(posedge clk);
			#1;
			data = 0;
			repeat (2) @(posedge clk);
			#1;
			data = 1;
			@(posedge clk);
			#1;
			data = 0;
		end 
	endtask


	initial begin
		#0;
		$dumpfile("fsm_tb.fst");
		$dumpvars(0, fsm_tb);
		
		//for when we have reset signal into the chip
		@(posedge clk);
		rst = 1'b1;
		// hold reset for a bit
		@(posedge clk);
		rst = 1'b0;
		#1;

		
		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;
		
		// should be in state 1
		checkState(1);

		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;

		// should be in state 2
		checkState(2);
		
		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;

		// should be in state 3
		checkState(3);
		
		@(posedge clk);
		#1;
		rst = 1;
		@(posedge clk);
		#1;
		rst = 0;
		
		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;
		
		// should be in state 1
		checkState(1);

		repeat (1000) @(posedge clk);
		// should time out.

		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;
		
		// should be in state 1
		checkState(1);


		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;

		// should be in state 2
		checkState(2);
		
		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;

		// should be in state 3
		checkState(3);

		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;
		
		// should be in addition state
		transmit1();

		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;

		transmit0();

		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;

		transmit1();

		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;

		transmit1();

		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;

		// should be in state wait to scan.
		checkState(8);

		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;

		checkState(9);

		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;

		checkState(10);

		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;

		checkState(9);

		$finish();
	end
endmodule
