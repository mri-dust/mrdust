
// Efinity Top-level template
// Version: 2021.2.323.2.18
// Date: 2022-05-18 20:46

// Copyright (C) 2017 - 2021 Efinix Inc. All rights reserved.

// This file may be used as a starting point for Efinity synthesis top-level target.
// The port list here matches what is expected by Efinity constraint files generated
// by the Efinity Interface Designer.

// To use this:
//     #1)  Save this file with a different name to a different directory, where source files are kept.
//              Example: you may wish to save as /home/mrdust/Documents/efinity/2021.2/project/rp_testing/rp_testing.v
//     #2)  Add the newly saved file into Efinity project as design file
//     #3)  Edit the top level entity in Efinity project to:  rp_testing
//     #4)  Insert design content.


module rp_testing
(
  input [1:0] BTN,
  input data_in,
  input pll_inst1,
  input pll_inst1_CLKOUT0,
  output [3:0] LED,
  output clk_output_inst,
  output to_osc
);


endmodule

