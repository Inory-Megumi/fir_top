set top            fir_top

set source_path   "./netlist"
#set source_path   "./netlist"

set search_path   ". \
                   /eda/synopsys/dc201312/libraries/syn \
                   /opt/Foundary_Library/TSMC65/tcbn65lpg_130b_ccs/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcbn65lpg_130b    \
                         /opt/Foundary_Library/TSMC65/tcbn65lpghvt_130b_ccs/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcbn65lpghvt_130b    \
                         /opt/Foundary_Library/TSMC65/tphn65lpgv2od3_sl_140a_nldm/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tphn65lpgv2od3_sl_140a    \
                  "

set link_path     "* \
                   tcbn65lpghvttc_ccst.db \
			tcbn65lpgtc_ccst.db  \
                   tphn65lpgv2od3_sltc.db \
                  "

# variable settings :
set_message_info -id RC-009   -limit 200                ;# inaccurate rc computations , 
set_message_info -id PARA-046 -limit 200                ;# try it, why so many ?

set si_enable_analysis true
set report_default_significant_digits 4
set timing_remove_clock_reconvergence_pessimism true
set timing_input_port_default_clock false
set timing_save_pin_arrival_and_slack true
set timing_report_unconstrained_paths true              ;# report timing more easier ,
set si_xtalk_double_switching_mode clock_network 
set timing_enable_multiple_clocks_per_reg true
#set timing_enable_preset_clear_arcs true

# read verilog :
read_verilog $source_path/$top.v
current_design $top
link

set_operating_conditions -analysis_type on_chip_variation NCCOM

# disable multi-threading capabilities , so read_parasitics will not at the background ,
# enable it ( default ) to read spef at the background faster , log as 'parasitics_command.log'
set_host_options -max_cores 2

# read spef : keep si effect ,
#read_parasitics -verbose -keep_capacitive_coupling -format SPEF $source_path/$top.spef.min

file mkdir reports
report_annotated_parasitics -check -list_not_annotated -max_nets 10000 -constant_arcs; # output to screen ,
report_annotated_parasitics -check -list_not_annotated -max_nets 20000 -constant_arcs > reports/report_annotated_parasitics.report 

complete_net_parasitics -complete_with zero

# source sdc , for each corner :
source $source_path/$top.sdc

# make sure after cts propagated : exclude virtual clocks ,
set_propagated_clock [filter_coll [all_clocks] "defined(sources)" ]

# set 0.1ns margin as setup, hold check ,
remove_clock_uncertainty [all_clocks]
set_clock_uncertainty -setup 0.0 [all_clocks]
set_clock_uncertainty -hold 0.0 [all_clocks]

# set drc rule : cap value is what ?
set_max_transition 0.4  [current_design]
set_max_capacitance 0.4 [current_design]

# differentiate between setup/hold check : different derate number , 
set_timing_derate -early 1.00 -clock
set_timing_derate -late 1.00 -clock

# group path to differ i/o path : copy from icc place.tcl group io path ,
# group path for internal and external path : please exclude clock port ,
set clk_ports { w_clk r_clk }
group_path -name in2reg -from [remove_from_coll [all_inputs] [get_ports $clk_ports]]
group_path -name in2out -from [remove_from_coll [all_inputs] [get_ports $clk_ports]] -to [all_outputs]
group_path -name reg2out -to [all_outputs]

# control latch timing borrow time : an option ,
#set_max_time_borrow 0.7 [all_clocks]
# can revise based on specific timing paths , refer to some latch cells only ,

# save session if needs :
update_timing -full
save_session pt.session 

# check timing : 
check_timing -verbose > reports/check_timing.report

# report timing : 
report_analysis_coverage > reports/report_analysis_coverage.report
report_global_timing  > reports/report_global_timing.rpt

report_timing -crosstalk_delta -slack_lesser_than 0 -delay max -derate -nosplit -input -net -cap -trans  \
-max_paths 1000 -nworst 1 > reports/report_timing_max.rpt

# min timing :
report_timing -crosstalk_delta -slack_lesser_than 0 -delay min -derate -nosplit -input -net -cap -trans  \
-max_paths 1000 -nworst 1 > reports/report_timing_min.rpt

report_clock_timing -type latency  >  reports/report_clock_timing.rpt
report_disable_timing > reports/report_disable_timing.report
report_constraints -all_violators > reports/all_violated.rpt 
report_design > reports/report_design.report 

# report noise , 
report_noise -nosplit -all_violators -above -low > reports/report_noise_all_viol_above_low.report 
report_noise -nosplit -nworst 10 -above -low > reports/report_noise_above_low.report 

report_noise -nosplit -all_violators -below -high > reports/report_noise_all_viol_below_high.report 
report_noise -nosplit -nworst 10 -below -high > reports/report_noise_below_high.report 

# Clock Network Double Switching Report
report_si_double_switching -nosplit -rise -fall > reports/report_si_double_switching.report 
report_clock -skew -attribute > reports/report_clock.report 

write_sdf -version 2.1 -input_port_nets -output_port_nets -context verilog -no_edge "$top.sdf"
#-no_negative_values

exit 

