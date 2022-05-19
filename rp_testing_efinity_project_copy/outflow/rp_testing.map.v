
//
// Verific Verilog Description of module testing
//

module testing (LED, BTN, pll_inst1_CLKOUT0, data_in, to_osc, clk_out);
    output [3:0]LED /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_OUTPUT=TRUE */ ;
    input [1:0]BTN /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;
    input pll_inst1_CLKOUT0 /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;
    input data_in /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_INPUT=TRUE */ ;
    output to_osc /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_OUTPUT=TRUE */ ;
    output clk_out /* verific EFX_ATTRIBUTE_PORT__IS_PRIMARY_OUTPUT=TRUE */ ;
    
    wire n76 /* verific EFX_ATTRIBUTE__IS_CMB_LOOP_NET=TRUE */ ;
    
    wire prev, n10, n11, n12, n13, \pll_inst1_CLKOUT0~O , n26, 
        n27, n28, n29, n30;
    
    EFX_LUT4 \dlatchrs_36/i2  (.I0(n28), .I1(n11), .I2(n26), .I3(n27), 
            .O(n11)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h00AC */ ;
    defparam \dlatchrs_36/i2 .LUTMASK = 16'h00AC;
    EFX_FF \clk_out_reg_2~FF  (.D(clk_out), .CE(1'b1), .CLK(\pll_inst1_CLKOUT0~O ), 
           .SR(BTN[0]), .Q(clk_out)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b0, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b0 */ ;   // /home/mrdust/Documents/efinity/2021.2/project/rp_testing/rp_testing.v(28)
    defparam \clk_out_reg_2~FF .CLK_POLARITY = 1'b1;
    defparam \clk_out_reg_2~FF .CE_POLARITY = 1'b1;
    defparam \clk_out_reg_2~FF .SR_POLARITY = 1'b0;
    defparam \clk_out_reg_2~FF .D_POLARITY = 1'b0;
    defparam \clk_out_reg_2~FF .SR_SYNC = 1'b1;
    defparam \clk_out_reg_2~FF .SR_VALUE = 1'b0;
    defparam \clk_out_reg_2~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_FF \prev~FF  (.D(data_in), .CE(1'b1), .CLK(\pll_inst1_CLKOUT0~O ), 
           .SR(BTN[0]), .Q(prev)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_FF, CLK_POLARITY=1'b1, D_POLARITY=1'b1, CE_POLARITY=1'b1, SR_SYNC=1'b1, SR_SYNC_PRIORITY=1'b1, SR_VALUE=1'b0, SR_POLARITY=1'b0 */ ;   // /home/mrdust/Documents/efinity/2021.2/project/rp_testing/rp_testing.v(28)
    defparam \prev~FF .CLK_POLARITY = 1'b1;
    defparam \prev~FF .CE_POLARITY = 1'b1;
    defparam \prev~FF .SR_POLARITY = 1'b0;
    defparam \prev~FF .D_POLARITY = 1'b1;
    defparam \prev~FF .SR_SYNC = 1'b1;
    defparam \prev~FF .SR_VALUE = 1'b0;
    defparam \prev~FF .SR_SYNC_PRIORITY = 1'b1;
    EFX_LUT4 \dlatchrs_36/i3  (.I0(n29), .I1(n12), .I2(n26), .I3(n27), 
            .O(n12)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h00AC */ ;
    defparam \dlatchrs_36/i3 .LUTMASK = 16'h00AC;
    EFX_LUT4 \dlatchrs_36/i4  (.I0(n30), .I1(n13), .I2(n26), .I3(n27), 
            .O(n13)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h00AC */ ;
    defparam \dlatchrs_36/i4 .LUTMASK = 16'h00AC;
    EFX_LUT4 LUT__42 (.I0(n76), .I1(BTN[0]), .O(to_osc)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h4444 */ ;
    defparam LUT__42.LUTMASK = 16'h4444;
    EFX_LUT4 \dlatchrs_36/i1  (.I0(LED[3]), .I1(n10), .I2(n26), .I3(n27), 
            .O(n10)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h00AC */ ;
    defparam \dlatchrs_36/i1 .LUTMASK = 16'h00AC;
    EFX_LUT4 LUT__43 (.I0(n76), .I1(BTN[0]), .O(n76)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h4444 */ ;
    defparam LUT__43.LUTMASK = 16'h4444;
    EFX_LUT4 LUT__44 (.I0(data_in), .I1(prev), .O(n26)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h4444 */ ;
    defparam LUT__44.LUTMASK = 16'h4444;
    EFX_LUT4 LUT__45 (.I0(n10), .I1(n11), .O(n28)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h6666 */ ;
    defparam LUT__45.LUTMASK = 16'h6666;
    EFX_LUT4 LUT__46 (.I0(n10), .I1(n11), .I2(n12), .O(n29)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h7878 */ ;
    defparam LUT__46.LUTMASK = 16'h7878;
    EFX_LUT4 LUT__47 (.I0(n10), .I1(n11), .I2(n12), .I3(n13), .O(n30)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h7f80 */ ;
    defparam LUT__47.LUTMASK = 16'h7f80;
    EFX_LUT4 LUT__50 (.I0(n10), .O(LED[3])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h5555, EFX_ATTRIBUTE_INSTANCE__IS_LUT_SOP_INF_INV=TRUE */ ;
    defparam LUT__50.LUTMASK = 16'h5555;
    EFX_LUT4 LUT__51 (.I0(n11), .O(LED[2])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h5555, EFX_ATTRIBUTE_INSTANCE__IS_LUT_SOP_INF_INV=TRUE */ ;
    defparam LUT__51.LUTMASK = 16'h5555;
    EFX_LUT4 LUT__52 (.I0(n12), .O(LED[1])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h5555, EFX_ATTRIBUTE_INSTANCE__IS_LUT_SOP_INF_INV=TRUE */ ;
    defparam LUT__52.LUTMASK = 16'h5555;
    EFX_LUT4 LUT__53 (.I0(n13), .O(LED[0])) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h5555, EFX_ATTRIBUTE_INSTANCE__IS_LUT_SOP_INF_INV=TRUE */ ;
    defparam LUT__53.LUTMASK = 16'h5555;
    EFX_LUT4 LUT__54 (.I0(BTN[0]), .O(n27)) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_LUT4, LUTMASK=16'h5555, EFX_ATTRIBUTE_INSTANCE__IS_LUT_SOP_INF_INV=TRUE */ ;
    defparam LUT__54.LUTMASK = 16'h5555;
    EFX_GBUFCE CLKBUF__0 (.CE(1'b1), .I(pll_inst1_CLKOUT0), .O(\pll_inst1_CLKOUT0~O )) /* verific EFX_ATTRIBUTE_CELL_NAME=EFX_GBUFCE, CE_POLARITY=1'b1 */ ;
    defparam CLKBUF__0.CE_POLARITY = 1'b1;
    
endmodule

//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_0
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF_e880bb9a_0
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_FF_e880bb9a_1
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_1
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_2
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_3
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_4
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_5
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_6
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_7
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_8
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_9
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_10
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_11
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_12
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_13
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_LUT4_e880bb9a_14
// module not written out since it is a black box. 
//


//
// Verific Verilog Description of module EFX_GBUFCE_e880bb9a_0
// module not written out since it is a black box. 
//

