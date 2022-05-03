sim:
	vcs  *.v -top tb_top -debug_all -R -gui -timescale=1ns/1ps -negdelay +neg_tchk +notimingcheck -l run.log
clean:
	rm -rf csrc DVEfiles simv.daidir *.log simv *.key *.vpd
.PHONY:
	sim clean
 
