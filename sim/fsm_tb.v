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

	fsm2 #(
		.TIMEOUT(10)
	) DUT (
		.rst(rst),
		.CLK_IN(clk), 
		.DATA_IN(data),
		.GLED5(led[0]), 
		.RLED1(led[1]), 
		.RLED2(led[2]), 
		.RLED3(led[3]), 
		.RLED4(led[4])
	);

	task resetDUT;
		begin
			@(posedge clk);
			#1;
			rst = 1;
			@(posedge clk);
			#1;
			rst = 0;
		end
	endtask

	task pulse;
		begin
			#1;
			data = 1;
			@(posedge clk);
			#1;
			data = 0;
			@(posedge clk);
		end
	endtask

	task checkState;
		input [3:0] state;
		begin
			#1;
			assert(DUT.cs == state) else begin 
				$error("%0t Current state is %d but expected %d!", $time, DUT.cs, state);
				$finish();
			end
		end
	endtask

	task checkDataOut;
		input [3:0] truth;
		begin
			@(posedge clk);
			#1;
			assert(DUT.dataStorage == truth) else begin 
				$error("%0t Saved data is incorrect!", $time);
				$finish();
			end
		end
	endtask


	// note that these tasks should be called when the circuit is either in state 3 (about to begin add and sub) or state 6 (about to go back to add/sub or move on to transmit).
	task transmit0;
		begin 
			pulse();
			$display("%0t starting transmit 0", $time);
			repeat(2) @(posedge clk);
			pulse();
			repeat (6) @(posedge clk);
			pulse();
		end 
	endtask
	task transmit1;
		begin 
			pulse();
			$display("%0t starting transmit 1", $time);
			repeat (6) @(posedge clk);
			pulse();
			repeat(2) @(posedge clk);
			pulse();
		end 
	endtask

	initial begin
		#0;
		$dumpfile("fsm_tb.fst");
		$dumpvars(0, fsm_tb);
		
		$display("Starting test 1: normal operation.");
		resetDUT();

		@(posedge clk);
		@(posedge clk);
		
		checkState(0);

		// go to state 1
		pulse();
		checkState(1);

		// go to state 2
		pulse();
		checkState(2);

		// go to state 3
		pulse();
		checkState(3);
		
		// begin the data transmission sequence
		transmit1();
		transmit0();
		transmit1();
		transmit1();

		// go to state to wait to scan.
		pulse();
		checkState(7);

		pulse();
		checkState(8);

		pulse();
		checkState(9);

		pulse();
		checkState(8);

		assert (DUT.amplitude == 4'b1011) else begin 
			$error("%0t Received Amplitude got %d but truth is %d", $time, DUT.amplitude, 4'b1011);
			$finish();
		end

		$display("Done with test 1!");

		$display("Starting test 2: force timeout conditions.");
		resetDUT();

		@(posedge clk);
		@(posedge clk);
		
		checkState(0);

		// go to state 1
		pulse();
		checkState(1);

		// time out the circuit while it is in state 1
		repeat (20) @(posedge clk);
		// should be back to the reset state
		checkState(0);

		// go to state 1
		pulse();
		checkState(1);
		// go to state 2
		pulse();
		checkState(2);

		$display("Done with test 2!");

		$display("done!");
		$finish();
	end
endmodule
