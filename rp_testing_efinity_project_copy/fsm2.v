module fsm2 #(
  parameter TIMEOUT = 1000
) (
	input CLK_IN_IN, 
	input DATA_IN,
	input rst,
	output GLED5, 
	output RLED1, 
	output RLED2, 
	output RLED3, 
	output RLED4,
);
    parameter IDLE = 2'b00;
    parameter S0 = 2'b01;
    parameter S1 = 2'b10;
    reg [1:0] out;
    reg [1:0] ns, cs;
    wire edge_out;

    edge_detector ed (.clk(CLK_IN), .dataIn(DATA_IN), .rst(rst), .dataOut(edge_out));

    always @(posedge CLK_IN) begin
        if (rst) cs <= IDLE;
        else cs <= ns;
    end

    assign GLED = out;

    always @(*) begin
        case (cs)
            IDLE: begin
                out = 2'b00;
                if (edge_out == 1) ns = S0;
                else ns = IDLE;
            end

            S0: begin
                out = 2'b01;
                if (edge_out == 1) ns = S1;
                else ns = S0;
            end

            S1: begin
                out = 2'b10;
                if (edge_out == 1) ns = IDLE;
                else ns = S1;
            end

            default: begin
                ns = IDLE;
                out = 2'b00;
            end
        endcase
    end
endmodule
