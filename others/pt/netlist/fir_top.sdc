###################################################################

# Created by write_sdc on Tue May  3 11:15:01 2022

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
set_max_capacitance 0.0244335 [current_design]
set_max_area 200000
set_load -pin_load 0.016289 [get_ports tdo]
set_load -pin_load 0.016289 [get_ports {w0[3]}]
set_load -pin_load 0.016289 [get_ports {w0[2]}]
set_load -pin_load 0.016289 [get_ports {w0[1]}]
set_load -pin_load 0.016289 [get_ports {w0[0]}]
set_load -pin_load 0.016289 [get_ports {w1[3]}]
set_load -pin_load 0.016289 [get_ports {w1[2]}]
set_load -pin_load 0.016289 [get_ports {w1[1]}]
set_load -pin_load 0.016289 [get_ports {w1[0]}]
set_load -pin_load 0.016289 [get_ports fir_open]
create_clock [get_ports w_clk]  -period 10  -waveform {0 1}
create_clock [get_ports r_clk]  -period 5  -waveform {0 1}
group_path -name COMO  -from [list [get_ports w_clk] [get_ports w_rstn] [get_ports tms] [get_ports   \
desync] [get_ports tdi] [get_ports r_clk] [get_ports r_rstn]]  -to [list [get_ports tdo] [get_ports {w0[3]}] [get_ports {w0[2]}] [get_ports  \
{w0[1]}] [get_ports {w0[0]}] [get_ports {w1[3]}] [get_ports {w1[2]}]           \
[get_ports {w1[1]}] [get_ports {w1[0]}] [get_ports fir_open]]
group_path -name INPUTS  -from [list [get_ports w_clk] [get_ports w_rstn] [get_ports tms] [get_ports   \
desync] [get_ports tdi] [get_ports r_clk] [get_ports r_rstn]]
group_path -name OUTPUTS  -to [list [get_ports tdo] [get_ports {w0[3]}] [get_ports {w0[2]}] [get_ports  \
{w0[1]}] [get_ports {w0[0]}] [get_ports {w1[3]}] [get_ports {w1[2]}]           \
[get_ports {w1[1]}] [get_ports {w1[0]}] [get_ports fir_open]]
set_input_delay -clock w_clk  -max 2.5  [get_ports w_clk]
set_input_delay -clock r_clk  -max 1.25  [get_ports r_clk]
set_input_delay -clock w_clk  -max 2.5  [get_ports w_rstn]
set_input_delay -clock w_clk  -max 2.5  [get_ports tms]
set_input_delay -clock w_clk  -max 2.5  [get_ports desync]
set_input_delay -clock w_clk  -max 2.5  [get_ports tdi]
set_input_delay -clock r_clk  -max 1.25  [get_ports r_rstn]
set_output_delay -clock w_clk  -max 2.5  [get_ports tdo]
set_output_delay -clock r_clk  -max 1.25  [get_ports {w0[3]}]
set_output_delay -clock r_clk  -max 1.25  [get_ports {w0[2]}]
set_output_delay -clock r_clk  -max 1.25  [get_ports {w0[1]}]
set_output_delay -clock r_clk  -max 1.25  [get_ports {w0[0]}]
set_output_delay -clock r_clk  -max 1.25  [get_ports {w1[3]}]
set_output_delay -clock r_clk  -max 1.25  [get_ports {w1[2]}]
set_output_delay -clock r_clk  -max 1.25  [get_ports {w1[1]}]
set_output_delay -clock r_clk  -max 1.25  [get_ports {w1[0]}]
set_output_delay -clock r_clk  -max 1.25  [get_ports fir_open]
