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
	output J3_5,
	output J3_6
);
    parameter IDLE = 2'b00;
    parameter S0 = 2'b01;
    parameter S1 = 2'b10;
    reg out = 0;
    reg [1:0] ns, cs;
    reg rst_led = 0;
    reg [20:0] sanity = 0;
    wire edge_out;
    wire prev_out;

    edge_detector ed (.clk(CLK_IN), .dataIn(DATA_IN), .rst(rst), .dataOut(edge_out), .p(prev_out));

    always @(posedge CLK_IN or posedge rst) begin
	    if (rst) begin
		rst_led <= 1;
		out <= 0;
		sanity <= 0;
	    end
	    else begin
		sanity <= sanity + 1;
		rst_led <= 0;
	    end
    end

    assign GLED5 = rst_led;
    assign RLED4 = prev_out;
    assign RLED1 = DATA_IN;
    assign RLED3 = out;
    assign RLED2 = sanity[20];
    assign J3_5 = DATA_IN;
    assign J3_6 = CLK_IN;

    always @(posedge RLED3) begin
	out <= 1;
    end
endmodule
