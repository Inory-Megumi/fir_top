#--------------------------------------------------------------------
#
#  Filename      : constraint.tcl
#  Author        : Ke Hongbo 
#  Created       : 2021-12-10
#  Description   : dc constraint tcl for booth
#
#  $Id$
#
#--------------------------------------------------------------------


#*** parameter setting *********************************************************

set WCLK "w_clk"
set WRST "w_rstn"
set RCLK "r_clk"
set RRST "r_rstn"
set WINPUT "w_clk  \
            w_rstn  \
	    tms   \
            desync \
	    tdi \
	    "
set RINPUT "r_clk  \
            r_rstn  \
            "
set WOUTPUT "tdo"
set ROUTPUT "w0  \
	     w1    \
             fir_open
            "


set WCLK_PERIOD 10.00
set RCLK_PERIOD 10.00
set clock_ports [get_ports $WCLK $RCLK]
set rst_ports [get_ports $WRST $RRST]
set input_ports [remove_from_collection [all_inputs] $clock_ports ]
set output_ports [get_ports [all_outputs]]

#*** CREATE CLOCKS *************************************************************

create_clock [get_ports $WCLK] -period $WCLK_PERIOD -waveform {0 1} -name $WCLK
create_clock [get_ports $RCLK] -period $RCLK_PERIOD -waveform {0 1} -name $RCLK
set_clock_latency 0  [get_clocks $clock_ports]
set_clock_latency -source 0  [get_clocks $clock_ports]
set_clock_uncertainty 0  [get_clocks $clock_ports]
set_dont_touch_network [get_ports $clock_ports]


#*** RST NETWORK ***************************************************************

set_ideal_network [get_ports $rst_ports]
set_false_path -from [get_ports $rst_ports]
set_dont_touch_network [get_ports $rst_ports]


#*** SET FALSE PATH AMONG CLOCKS ***********************************************
set_false_path -from [get_ports $WCLK] -to [get_ports $RCLK]
set_false_path -from [get_ports $RCLK] -to [get_ports $WCLK]

#*** SET PORTS DELAY ***********************************************************

# sys domain
set_input_delay  -max [expr $WCLK_PERIOD*0.25] -clock $WCLK [get_ports $WINPUT]
set_input_delay  -max [expr $RCLK_PERIOD*0.25] -clock $RCLK [get_ports $RINPUT]
set_output_delay -max [expr $WCLK_PERIOD*0.25] -clock $WCLK [get_ports $WOUTPUT]
set_output_delay -max [expr $RCLK_PERIOD*0.25] -clock $RCLK [get_ports $ROUTPUT]

#*** SET WIRE LOAD *************************************************************

#set_wire_load_mode top

#*** DRIVING AND LOADING *******************************************************
set REF_DRIVE_CELL BUFHSV4
set driving_cell -lib_cell $REF_DRIVE_CELL $input_ports
set MAX_LOAD 0.0016289

set_drive 0 $clock_ports
set_drive 0 $rst_ports

#set_max_transition 0.2 [current_design]
#set_max_fanout 10 [current_design]
set_max_capacitance [expr $MAX_LOAD*15] [all_designs]
set_load [expr $MAX_LOAD*10] [all_outputs]
#set_load 0.5 [all_outputs]

