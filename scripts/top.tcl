#--------------------------------------------------------------------
#
#  Filename      : top.tcl
#  Author        : Ke Hongbo
#  Created       : 2022-4-25
#  Description   : dc top tcl for top
#
#  $Id$
#
#--------------------------------------------------------------------

#*** define directory **********************************************************

  set topDir            "."
  set rtlDir            "$topDir/rtl"
  set incDir            "$topDir/include"
  set synDir            "$topDir/syn"
  set dbDir             "$synDir/db"
  set reportsDir        "$synDir/rpt"
  set netlistDir        "$synDir/netlist"
  set svfDir            "$synDir/svf"


#*** DESIGN COMPILE SYSTEM SETTING *********************************************

  set search_path       ".          \
                         $rtlDir    \
                         $incDir    \
                         $dbDir     \
                         /opt/Synopsys/Synplify2015/libraries/syn     \
                         /opt/Foundary_Library/TSMC65/tcbn65lpg_130b_ccs/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcbn65lpg_130b    \
                         /opt/Foundary_Library/TSMC65/tcbn65lpghvt_130b_ccs/TSMCHOME/digital/Front_End/timing_power_noise/CCS/tcbn65lpghvt_130b    \
                         /opt/Foundary_Library/TSMC65/tphn65lpgv2od3_sl_140a_nldm/TSMCHOME/digital/Front_End/timing_power_noise/NLDM/tphn65lpgv2od3_sl_140a    \
                        "

  set target_library_ss "tcbn65lpgwc_ccs.db tcbn65lpghvtwc_ccs.db"
  set target_library_tt "tcbn65lpghvttc_ccst.db tcbn65lpgtc_ccst.db"
  set target_library_ff "tcbn65lpgbc_ccs.db tcbn65lpghvtbc_ccs.db"

  set target_library    "$target_library_tt"

  set synthetic_library "dw_foundation.sldb"
  set IO_library        "tphn65lpgv2od3_sltc.db"
  set DW_LIB            "standard.sldb "

  set link_library      "*                     \
                         $target_library       \
                         $DW_LIB               \
                         $synthetic_library    \
                         $IO_library           \
                        "

  set cache_write       ~/

  set cache_read        $cache_write


#########################################

  alias h history
  # alias rt "report_timing"
  # alias ra "report_area"
  # alias rc "report_constraint -all_violators"

  history keep 100

  # specify directory for intermediate files from analyze
  define_design_lib DEFAULT -path ./analyzed

  # suppress Driving cell warning
  suppress_message {UID-401 DDB-24}

  #set_fix_multiple_port_nets -buffer_constants -all
  #set_fix_multiple_port_nets -feedthroughs

  set verilogout_no_tri true
  define_name_rules BORG -allowed {A-Za-z0-9_} -first_restricted "_" -last_restricted "_" -max_length 30

  set verilogout_no_tri true

  # specify varibles
  set sh_enable_line_editing true


#*** TOP FILE ******************************************************************

  set topModule             fir_top

  set srcFile               $topDir/scripts/read_src.tcl
  set constraintFile        $topDir/scripts/constraint.tcl

  #set SCAN_FF              smic13_ss/FFS*
  set FLATTEN               true
  set STRUCTURE             false
  set MODULE_COMPILER       true
  set AREA_CONSTRAINT       200000
  set CRITICAL_RANGE        3
  set TIMING_RPT_NUM        40

  # compiler switches...                  
  set useUltra 1           ;# 1 for compile_ultra, 0 for compile
                            # mapEffort, useUngroup are for    
                            # non-ultra compile...         
  set mapEffort1 high      ;# First pass - low, medium, or high
  set mapEffort2 medium    ;# second pass - low, medium, or high
  set useUngroup 1         ;# 0 if no flatten, 1 if flatten


#*** READ THE SOURCE FILE ******************************************************

  source $srcFile

  # regardless of the scan cell
  # set_dont_use $SCAN_FF

#*** READ THE CONSTRAINT FILE **************************************************

  source -e -v $constraintFile

  #verify the constraints
  redirect  $reportsDir/$topModule\_timing_check.rpt {check_timing}
  redirect  $reportsDir/$topModule\_port.rpt {report_port -verbose}


#*** Set Compiler Settings *****************************************************

  #logic-level optimization
  set_flatten $FLATTEN
  set_structure $STRUCTURE

  #Enables the Synopsys Module Compiler to generate arithmetic DesignWare parts.
  set dw_prefer_mc_inside $MODULE_COMPILER

  #partition_dp

  #specifying an area goal
  set_max_area $AREA_CONSTRAINT

  #creating custom path groups
  group_path -name OUTPUTS -to [all_outputs]
  group_path -name INPUTS -from [all_inputs]
  group_path -name COMO -from [all_inputs] -to [all_outputs]

  #specifying the critical range to improve more paths
  set_critical_range $CRITICAL_RANGE [get_designs *]

  #inserts extra logic into the design to ensure that there are no 
  #feedthroughs, or that there are no two output ports connected to 
  #the same net at any level of hierarchy
  set_fix_multiple_port_nets -buffer_constants -all

#*** Compile the design ********************************************************

  #use multicore to accelearate
  set_host_options -max_core 2
  
  if { $useUltra == 1 } {
    compile_ultra
  } else {
    if { $useUngroup == 1 } {
      compile -ungroup_all -map_effort $mapEffort1
      compile -incremental_mapping -map_effort $mapEffort2
    } else {
      compile -map_effort $mapEffort1
      compile -incremental_mapping -map_effort $mapEffort2
    }
  }

#*** Report Design *************************************************************

  check_design > $reportsDir/$topModule\_checkdesign.rpt
  report_constraint -all_violators

  #define name rules and change the names in the design according to the rules
  define_name_rules "IS_rule" -max_length "255" -allowed "a-zA-Z0-9_$"  -replacement_char "_" -type cell
  define_name_rules "IS_rule" -max_length "255" -allowed "a-zA-Z0-9_$"  -replacement_char "_" -type net
  define_name_rules "IS_rule" -max_length "255" -allowed "a-zA-Z0-9_$[]"  -replacement_char "_" -type port
  change_names -rules "IS_rule" -hierarchy

  #dump netlist
  write -hierarchy -output $netlistDir/$topModule\.db
  write -format ddc -hierarchy -output $netlistDir/$topModule\.ddc
  write -hierarchy -format verilog -output $netlistDir/$topModule\.v
  write_sdc  $netlistDir/$topModule\.sdc
  write_sdf  $netlistDir/$topModule\.sdf

  #dump reports 
  report_constraints -all_violators -verbose > $reportsDir/$topModule\_vio.rpt
  report_timing -max $TIMING_RPT_NUM > $reportsDir/$topModule\_timing.rpt
  report_area -hierarchy > $reportsDir/$topModule\_area.rpt
  report_power > $reportsDir/$topModule\_power.rpt

  quit
