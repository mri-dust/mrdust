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

	module fsm #(
		timeout=1000
	)(
		.CLK_IN(clk), 
		.DATA_IN(data),
		.GLED5(led[0]), 
		.RLED1(led[1]), 
		.RLED2(led[2]), 
		.RLED3(led[3]), 
		.RLED4(led[4])
	);

	task transmit0;
		begin 
			repeat(2) @posedge(clk);
			#1;
			data = 1;
			@posedge(clk);
			#1;
			data = 0;
			for (i = 0; i < 6; i = i + 1) begin
				@posedge(clk);
			end
			#1;
			data = 1;
			@posedge(clk);
			#1;
			data = 0;
		end 
	endtask

	task transmit1;
		begin 
			for (i = 0; i < 6; i = i + 1) begin
				@posedge(clk);
			end
			#1;
			data = 1;
			@posedge(clk);
			#1;
			data = 0;
			repeat(2) @posedge(clk);
			#1;
			data = 1;
			@posedge(clk);
			#1;
			data = 0;
		end 
	endtask


	initial begin
		#0;
		$dumpfile("fsm_tb.fst");
		$dumpvars(0, axi_stream_mux_tb);
		
		// for when we have reset signal into the chip
		// // note the reset signal is on asynchronous low
		// @(posedge clk);
		// rst = 1'b0;
		// // hold reset for a bit
		// @(posedge clk);
		// rst = 1'b1;
		// #1;

		
		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;
		
		// should be in state 1


		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;
		
		@(posedge clk);
		#1;
		data = 1;
		@(posedge clk);
		#1;
		data = 0;

