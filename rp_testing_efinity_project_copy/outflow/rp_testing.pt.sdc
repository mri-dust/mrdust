
# Efinity Interface Designer SDC
# Version: 2021.2.323.2.18
# Date: 2022-05-18 20:46

# Copyright (C) 2017 - 2021 Efinix Inc. All rights reserved.

# Device: T8F81
# Project: rp_testing
# Timing Model: C2 (final)

# PLL Constraints
#################
create_clock -period 10.00 -waveform {5.00 10.00} [get_ports {pll_inst1_CLKOUT0}]

# GPIO Constraints
####################
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {BTN[0]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {BTN[0]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {BTN[1]}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {BTN[1]}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {data_in}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {data_in}]
# set_input_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {pll_inst1}]
# set_input_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {pll_inst1}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {clk_output_inst}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {clk_output_inst}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {LED[0]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {LED[0]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {LED[1]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {LED[1]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {LED[2]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {LED[2]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {LED[3]}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {LED[3]}]
# set_output_delay -clock <CLOCK> -max <MAX CALCULATION> [get_ports {to_osc}]
# set_output_delay -clock <CLOCK> -min <MIN CALCULATION> [get_ports {to_osc}]
