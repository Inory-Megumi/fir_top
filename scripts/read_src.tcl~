#--------------------------------------------------------------------
#
#  Filename      : read_src.tcl
#  Author        : Ke Hongbo
#  Created       : 2022-4-25
#  Description   : dc read source tcl for top
#
#  $Id$
#
#--------------------------------------------------------------------

  define_design_lib work -path work
  set_svf ${svfDir}/${topModule}.svf

#*** READ SOURCE ***************************************************************
  analyze -format verilog -lib work $rtlDir/top.v
  analyze -format verilog -lib work $rtlDir/jtag_top.v
  analyze -format verilog -lib work $rtlDir/tap.v
  analyze -format verilog -lib work $rtlDir/bi2gray.v
  analyze -format verilog -lib work $rtlDir/fifo_top.v
  analyze -format verilog -lib work $rtlDir/ram.v
  analyze -format verilog -lib work $rtlDir/rd_controller.v
  analyze -format verilog -lib work $rtlDir/synchronizer.v
  analyze -format verilog -lib work $rtlDir/wr_controller.v
  analyze -format verilog -lib work $rtlDir/config.v


#*** ELABORATE TOP MODULE ******************************************************

  elaborate $topModule -arch "verilog" -lib work 
  current_design $topModule


#*** CHECK UNRESOLVED REFERENCE ************************************************

  link
  if { [link] == 0 } {
  	echo "Linking Error when deal with $topModule"
  	exit;
  }

#*** CHECK DESIGN **************************************************************

  uniquify
  if { [check_design] == 0 } {
  	echo "Check Design Error when deal with $topModule"
  	exit;
  }
