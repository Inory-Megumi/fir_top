#-------------------------------------------------------------------
#
#  Filename      : makefile

#  Description   : makefile to run dc
#
#  $Id
#
#-------------------------------------------------------------------

setup:
	mkdir syn/work syn/rpt syn/netlist syn/log syn/svf syn/db

syn:	
	dc_shell-xg-t -f ./scripts/top.tcl |tee -i run_dc.log
clean:
	rm -rf ./syn/* ./*.log ./*.svf ./*.txt alib-52 work
.PHONY: syn clean
