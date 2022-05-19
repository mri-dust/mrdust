`default_nettype wire

// define a Count module
module testing(
    output [3:0] LED,
    input [1:0] BTN,
    input pll_inst1_CLKOUT0,    
    input data_in,
    output to_osc,
    output clk_out
);
	// define a 24-bit counter to divide the clock down from 12MHz
    reg [3:0] counter;
    reg out;
    reg prev;
    reg clk_out_reg;
    wire data_in_sync;
    
    always @(posedge pll_inst1_CLKOUT0) begin
        if (~BTN[0]) begin
            prev <= 0;
            clk_out_reg <= 0;
        end
        else begin
            prev <= data_in;
            clk_out_reg <= ~clk_out_reg;
        end
    end

    assign data_in_sync = prev & ~data_in;
    
    // run counter from 12MHz clock
    always @(data_in_sync or BTN[0]) begin
        if (~BTN[0]) begin
            counter <= 0;
        end 
        else if (data_in_sync) begin
            counter <= counter + 1;
        end
    end
    
    always @(data_in_sync or BTN[0]) begin
        if (~BTN[0]) out <= 0;
        else out <= ~out;
    end
    
	assign to_osc = out;
    assign clk_out = clk_out_reg;
	assign LED[0] = ~counter[3];
	assign LED[1] = ~counter[2];
	assign LED[2] = ~counter[1];
	assign LED[3] = ~counter[0];	

                 
endmodule        
                 
                 
