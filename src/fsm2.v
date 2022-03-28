module fsm2 (clk, rst, in, out);
    input clk, rst, in;
    output [1:0] out;

    parameter IDLE = 2'b00;
    parameter S0 = 2'b01;
    parameter S1 = 2'b10;
    reg [1:0] out;
    reg [1:0] ns, cs;
    wire edge_out;

    edge_detector ed (.clk(clk), .dataIn(in), .rst(rst), .dataOut(edge_out));

    always @(posedge clk) begin
        if (rst) cs <= IDLE;
        else cs <= ns;
    end

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