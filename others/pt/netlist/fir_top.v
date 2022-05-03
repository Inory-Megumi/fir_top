/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : K-2015.06
// Date      : Tue May  3 11:15:01 2022
/////////////////////////////////////////////////////////////


module fir_top ( w_clk, w_rstn, tms, desync, tdi, r_clk, r_rstn, tdo, w0, w1, 
        fir_open );
  output [3:0] w0;
  output [3:0] w1;
  input w_clk, w_rstn, tms, desync, tdi, r_clk, r_rstn;
  output tdo, fir_open;
  wire   my_jtag_N92, my_jtag_tdo_o, my_jtag_sync, my_jtag_BypReg,
         my_config_w_select_1_, my_config_N12, my_config_next_state,
         my_config_state, n168, n169, n170, n171, n172, n173, n174, n175, n176,
         n177, n178, n179, n180, n181, n182, n183, n184, n185, n186, n187,
         n188, n189, n190, n191, n192, n193, n194, n195, n196, n197, n198,
         n199, n200, n201, n202, n203, n204, n205, n206, n207, n208, n209,
         n210, n211, n212, n213, n214, n215, n216, n217, n218, n219, n220,
         n221, n222, n223, n224, n225, n226, n227, n228, n229, n230, n231,
         n232, n233, n234, n235, n236, n237, n238, n239, n240, n241, n242,
         n243, n244, n245, n246, n247, n248, n249, n250, n251, n252, n253,
         n254, n255, n256, n257, n258, n259, n260, n261, n262, n263, n264,
         n265, n266, n267, n268, n269, n270, n271, n272, n273, n274, n275,
         n276, n277, n278, n279, n280, n281, n282, n283, n284, n285, n286,
         n287, n288, n289, n290, n291, n292, n293, n294, n295, n296, n297,
         n298, n299, n300, n301, n302, n303, n304, n305, n306, n307, n308,
         n309, n310, n311, n312, n313, n314, n315, n316, n317, n318, n319,
         n320, n321, n322, n323, n324, n325, n326, n327, n328, n329, n330,
         n331, n332, n333, n334, n335, n336, n337, n338, n339, n340, n341,
         n342, n343, n344, n345, n346, n347, n348, n349, n350, n351, n352,
         n353, n354, n355, n356, n357, n358, n359, n360, n361, n362, n363,
         n364, n365, n366, n367, n368, n369, n370, n371, n372, n373, n374,
         n375, n376, n377, n378, n379, n380, n381, n382, n383, n384, n385,
         n386, n387, n388, n389, n390, n391, n392, n393, n394, n395, n396,
         n397, n398, n399, n400, n401, n402, n403, n404, n405, n406, n407,
         n408, n409, n410, n411, n412, n413, n414, n415, n416, n417, n418,
         n419, n420, n421, n422, n423, n424, n425, n426, n427, n428, n429,
         n430, n431, n432, n433, n434, n435, n436, n437, n438, n439, n440,
         n441, n442, n443, n444, n445, n446, n447, n448, n449, n450, n451,
         n452, n453, n454, n455, n456, n457, n458, n459, n460, n461, n462,
         n463, n464, n465, n466, n467, n468, n470, n471, n472, n473, n474,
         n475, n476, n477, n478, n479, n480, n481, n482, n483, n484, n485;
  wire   [3:0] wr_data;
  wire   [3:0] rd_data;
  wire   [1:0] my_jtag_SftCnt;
  wire   [1:0] my_jtag_IR;
  wire   [1:0] my_jtag_SIR;
  wire   [3:0] my_jtag_state;
  wire   [3:0] my_fifo_rd_addr;
  wire   [4:0] my_fifo_rd_ptr;
  wire   [4:0] my_fifo_wrsync_ptr;
  wire   [3:0] my_fifo_wr_addr;
  wire   [4:0] my_fifo_wr_ptr;
  wire   [4:0] my_fifo_rdsync_ptr;
  wire   [3:0] my_jtag_tap_next_state;
  wire   [4:0] my_fifo_wr_ctrl_wr_gray;
  wire   [4:0] my_fifo_rd_ctrl_rd_gray;
  wire   [4:0] my_fifo_sync_r2w_ff_temp;
  wire   [63:0] my_fifo_dual_ram_mem;
  wire   [4:0] my_fifo_sync_w2r_ff_temp;

  DFNCND1GHVT my_jtag_tdo_t_reg ( .D(my_jtag_N92), .CPN(w_clk), .CDN(n474), 
        .QN(n470) );
  DFNCND1GHVT my_jtag_IR_reg_1_ ( .D(n263), .CPN(w_clk), .CDN(n474), .Q(
        my_jtag_IR[1]), .QN(n471) );
  DFNCND1GHVT my_jtag_IR_reg_0_ ( .D(n264), .CPN(w_clk), .CDN(n474), .Q(
        my_jtag_IR[0]) );
  DFNCND1GHVT my_jtag_tdo_o_reg ( .D(n260), .CPN(w_clk), .CDN(n474), .Q(
        my_jtag_tdo_o) );
  DFCNQD1GHVT my_jtag_SIR_reg_1_ ( .D(n266), .CP(w_clk), .CDN(n474), .Q(
        my_jtag_SIR[1]) );
  DFCNQD1GHVT my_jtag_SIR_reg_0_ ( .D(n265), .CP(w_clk), .CDN(w_rstn), .Q(
        my_jtag_SIR[0]) );
  DFCNQD1GHVT my_jtag_BypReg_reg ( .D(n262), .CP(w_clk), .CDN(w_rstn), .Q(
        my_jtag_BypReg) );
  DFCNQD1GHVT my_jtag_SCF_reg_3_ ( .D(n257), .CP(w_clk), .CDN(w_rstn), .Q(
        wr_data[3]) );
  DFCNQD1GHVT my_jtag_SCF_reg_2_ ( .D(n258), .CP(w_clk), .CDN(w_rstn), .Q(
        wr_data[2]) );
  DFCNQD1GHVT my_jtag_SCF_reg_1_ ( .D(n259), .CP(w_clk), .CDN(w_rstn), .Q(
        wr_data[1]) );
  DFCNQD1GHVT my_jtag_sync_reg ( .D(n256), .CP(w_clk), .CDN(n480), .Q(
        my_jtag_sync) );
  DFCNQD1GHVT my_jtag_SftCnt_reg_0_ ( .D(n254), .CP(w_clk), .CDN(n480), .Q(
        my_jtag_SftCnt[0]) );
  DFCNQD1GHVT my_jtag_SftCnt_reg_1_ ( .D(n255), .CP(w_clk), .CDN(n480), .Q(
        my_jtag_SftCnt[1]) );
  DFCNQD1GHVT my_fifo_sync_w2r_ff_temp_reg_4_ ( .D(my_fifo_wr_ptr[4]), .CP(
        r_clk), .CDN(n472), .Q(my_fifo_sync_w2r_ff_temp[4]) );
  DFCNQD1GHVT my_fifo_sync_w2r_output_signal_reg_4_ ( .D(
        my_fifo_sync_w2r_ff_temp[4]), .CP(r_clk), .CDN(n472), .Q(
        my_fifo_wrsync_ptr[4]) );
  DFCNQD1GHVT my_fifo_rd_ctrl_rd_bin_reg_0_ ( .D(n253), .CP(r_clk), .CDN(n472), 
        .Q(my_fifo_rd_addr[0]) );
  DFCNQD1GHVT my_fifo_rd_ctrl_rd_bin_reg_1_ ( .D(n252), .CP(r_clk), .CDN(n472), 
        .Q(my_fifo_rd_addr[1]) );
  DFCNQD1GHVT my_fifo_rd_ctrl_rd_ptr_reg_0_ ( .D(my_fifo_rd_ctrl_rd_gray[0]), 
        .CP(r_clk), .CDN(n472), .Q(my_fifo_rd_ptr[0]) );
  DFCNQD1GHVT my_fifo_sync_r2w_ff_temp_reg_0_ ( .D(my_fifo_rd_ptr[0]), .CP(
        w_clk), .CDN(n480), .Q(my_fifo_sync_r2w_ff_temp[0]) );
  DFCNQD1GHVT my_fifo_sync_r2w_output_signal_reg_0_ ( .D(
        my_fifo_sync_r2w_ff_temp[0]), .CP(w_clk), .CDN(n480), .Q(
        my_fifo_rdsync_ptr[0]) );
  DFCNQD1GHVT my_fifo_rd_ctrl_rd_bin_reg_2_ ( .D(n251), .CP(r_clk), .CDN(n472), 
        .Q(my_fifo_rd_addr[2]) );
  DFCNQD1GHVT my_fifo_rd_ctrl_rd_ptr_reg_1_ ( .D(my_fifo_rd_ctrl_rd_gray[1]), 
        .CP(r_clk), .CDN(n472), .Q(my_fifo_rd_ptr[1]) );
  DFCNQD1GHVT my_fifo_sync_r2w_ff_temp_reg_1_ ( .D(my_fifo_rd_ptr[1]), .CP(
        w_clk), .CDN(n480), .Q(my_fifo_sync_r2w_ff_temp[1]) );
  DFCNQD1GHVT my_fifo_sync_r2w_output_signal_reg_1_ ( .D(
        my_fifo_sync_r2w_ff_temp[1]), .CP(w_clk), .CDN(n479), .Q(
        my_fifo_rdsync_ptr[1]) );
  DFCNQD1GHVT my_fifo_rd_ctrl_rd_bin_reg_3_ ( .D(n250), .CP(r_clk), .CDN(n473), 
        .Q(my_fifo_rd_addr[3]) );
  DFCNQD1GHVT my_fifo_rd_ctrl_rd_ptr_reg_2_ ( .D(my_fifo_rd_ctrl_rd_gray[2]), 
        .CP(r_clk), .CDN(n473), .Q(my_fifo_rd_ptr[2]) );
  DFCNQD1GHVT my_fifo_sync_r2w_ff_temp_reg_2_ ( .D(my_fifo_rd_ptr[2]), .CP(
        w_clk), .CDN(n479), .Q(my_fifo_sync_r2w_ff_temp[2]) );
  DFCNQD1GHVT my_fifo_sync_r2w_output_signal_reg_2_ ( .D(
        my_fifo_sync_r2w_ff_temp[2]), .CP(w_clk), .CDN(n479), .Q(
        my_fifo_rdsync_ptr[2]) );
  DFCNQD1GHVT my_fifo_rd_ctrl_rd_bin_reg_4_ ( .D(n249), .CP(r_clk), .CDN(n473), 
        .Q(my_fifo_rd_ctrl_rd_gray[4]) );
  DFCNQD1GHVT my_fifo_rd_ctrl_rd_ptr_reg_4_ ( .D(my_fifo_rd_ctrl_rd_gray[4]), 
        .CP(r_clk), .CDN(n473), .Q(my_fifo_rd_ptr[4]) );
  DFCNQD1GHVT my_fifo_sync_r2w_ff_temp_reg_4_ ( .D(my_fifo_rd_ptr[4]), .CP(
        w_clk), .CDN(n479), .Q(my_fifo_sync_r2w_ff_temp[4]) );
  DFCNQD1GHVT my_fifo_sync_r2w_output_signal_reg_4_ ( .D(
        my_fifo_sync_r2w_ff_temp[4]), .CP(w_clk), .CDN(n479), .Q(
        my_fifo_rdsync_ptr[4]) );
  DFCNQD1GHVT my_fifo_rd_ctrl_rd_ptr_reg_3_ ( .D(my_fifo_rd_ctrl_rd_gray[3]), 
        .CP(r_clk), .CDN(n473), .Q(my_fifo_rd_ptr[3]) );
  DFCNQD1GHVT my_fifo_sync_r2w_ff_temp_reg_3_ ( .D(my_fifo_rd_ptr[3]), .CP(
        w_clk), .CDN(n479), .Q(my_fifo_sync_r2w_ff_temp[3]) );
  DFCNQD1GHVT my_fifo_sync_r2w_output_signal_reg_3_ ( .D(
        my_fifo_sync_r2w_ff_temp[3]), .CP(w_clk), .CDN(n479), .Q(
        my_fifo_rdsync_ptr[3]) );
  DFCNQD1GHVT my_fifo_wr_ctrl_wr_bin_reg_0_ ( .D(n248), .CP(w_clk), .CDN(n478), 
        .Q(my_fifo_wr_addr[0]) );
  DFCNQD1GHVT my_fifo_wr_ctrl_wr_bin_reg_1_ ( .D(n247), .CP(w_clk), .CDN(n478), 
        .Q(my_fifo_wr_addr[1]) );
  DFCNQD1GHVT my_fifo_wr_ctrl_wr_ptr_reg_0_ ( .D(my_fifo_wr_ctrl_wr_gray[0]), 
        .CP(w_clk), .CDN(n478), .Q(my_fifo_wr_ptr[0]) );
  DFCNQD1GHVT my_fifo_sync_w2r_ff_temp_reg_0_ ( .D(my_fifo_wr_ptr[0]), .CP(
        r_clk), .CDN(n473), .Q(my_fifo_sync_w2r_ff_temp[0]) );
  DFCNQD1GHVT my_fifo_sync_w2r_output_signal_reg_0_ ( .D(
        my_fifo_sync_w2r_ff_temp[0]), .CP(r_clk), .CDN(n473), .Q(
        my_fifo_wrsync_ptr[0]) );
  DFCNQD1GHVT my_fifo_wr_ctrl_wr_bin_reg_2_ ( .D(n246), .CP(w_clk), .CDN(n478), 
        .Q(my_fifo_wr_addr[2]) );
  DFCNQD1GHVT my_fifo_wr_ctrl_wr_ptr_reg_1_ ( .D(my_fifo_wr_ctrl_wr_gray[1]), 
        .CP(w_clk), .CDN(n478), .Q(my_fifo_wr_ptr[1]) );
  DFCNQD1GHVT my_fifo_sync_w2r_ff_temp_reg_1_ ( .D(my_fifo_wr_ptr[1]), .CP(
        r_clk), .CDN(r_rstn), .Q(my_fifo_sync_w2r_ff_temp[1]) );
  DFCNQD1GHVT my_fifo_sync_w2r_output_signal_reg_1_ ( .D(
        my_fifo_sync_w2r_ff_temp[1]), .CP(r_clk), .CDN(n473), .Q(
        my_fifo_wrsync_ptr[1]) );
  DFCNQD1GHVT my_fifo_wr_ctrl_wr_bin_reg_3_ ( .D(n245), .CP(w_clk), .CDN(n478), 
        .Q(my_fifo_wr_addr[3]) );
  DFCNQD1GHVT my_fifo_wr_ctrl_wr_ptr_reg_2_ ( .D(my_fifo_wr_ctrl_wr_gray[2]), 
        .CP(w_clk), .CDN(n478), .Q(my_fifo_wr_ptr[2]) );
  DFCNQD1GHVT my_fifo_sync_w2r_ff_temp_reg_2_ ( .D(my_fifo_wr_ptr[2]), .CP(
        r_clk), .CDN(n472), .Q(my_fifo_sync_w2r_ff_temp[2]) );
  DFCNQD1GHVT my_fifo_sync_w2r_output_signal_reg_2_ ( .D(
        my_fifo_sync_w2r_ff_temp[2]), .CP(r_clk), .CDN(r_rstn), .Q(
        my_fifo_wrsync_ptr[2]) );
  DFCNQD1GHVT my_fifo_wr_ctrl_wr_bin_reg_4_ ( .D(n244), .CP(w_clk), .CDN(n477), 
        .Q(my_fifo_wr_ctrl_wr_gray[4]) );
  DFCNQD1GHVT my_fifo_wr_ctrl_wr_ptr_reg_4_ ( .D(my_fifo_wr_ctrl_wr_gray[4]), 
        .CP(w_clk), .CDN(n477), .Q(my_fifo_wr_ptr[4]) );
  DFCNQD1GHVT my_fifo_wr_ctrl_wr_ptr_reg_3_ ( .D(my_fifo_wr_ctrl_wr_gray[3]), 
        .CP(w_clk), .CDN(n477), .Q(my_fifo_wr_ptr[3]) );
  DFCNQD1GHVT my_fifo_sync_w2r_ff_temp_reg_3_ ( .D(my_fifo_wr_ptr[3]), .CP(
        r_clk), .CDN(n472), .Q(my_fifo_sync_w2r_ff_temp[3]) );
  DFCNQD1GHVT my_fifo_sync_w2r_output_signal_reg_3_ ( .D(
        my_fifo_sync_w2r_ff_temp[3]), .CP(r_clk), .CDN(r_rstn), .Q(
        my_fifo_wrsync_ptr[3]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_15__0_ ( .D(n243), .CP(w_clk), .CDN(
        n477), .Q(my_fifo_dual_ram_mem[0]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_15__1_ ( .D(n242), .CP(w_clk), .CDN(
        n477), .Q(my_fifo_dual_ram_mem[1]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_15__2_ ( .D(n241), .CP(w_clk), .CDN(
        n477), .Q(my_fifo_dual_ram_mem[2]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_15__3_ ( .D(n240), .CP(w_clk), .CDN(
        n477), .Q(my_fifo_dual_ram_mem[3]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_13__0_ ( .D(n235), .CP(w_clk), .CDN(
        n478), .Q(my_fifo_dual_ram_mem[8]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_13__1_ ( .D(n234), .CP(w_clk), .CDN(
        n477), .Q(my_fifo_dual_ram_mem[9]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_13__2_ ( .D(n233), .CP(w_clk), .CDN(
        n476), .Q(my_fifo_dual_ram_mem[10]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_13__3_ ( .D(n232), .CP(w_clk), .CDN(
        n482), .Q(my_fifo_dual_ram_mem[11]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_11__0_ ( .D(n227), .CP(w_clk), .CDN(
        n478), .Q(my_fifo_dual_ram_mem[16]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_11__1_ ( .D(n226), .CP(w_clk), .CDN(
        n477), .Q(my_fifo_dual_ram_mem[17]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_11__2_ ( .D(n225), .CP(w_clk), .CDN(
        n476), .Q(my_fifo_dual_ram_mem[18]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_11__3_ ( .D(n224), .CP(w_clk), .CDN(
        n476), .Q(my_fifo_dual_ram_mem[19]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_9__0_ ( .D(n219), .CP(w_clk), .CDN(n476), .Q(my_fifo_dual_ram_mem[24]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_9__1_ ( .D(n218), .CP(w_clk), .CDN(n476), .Q(my_fifo_dual_ram_mem[25]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_9__2_ ( .D(n217), .CP(w_clk), .CDN(n476), .Q(my_fifo_dual_ram_mem[26]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_9__3_ ( .D(n216), .CP(w_clk), .CDN(n476), .Q(my_fifo_dual_ram_mem[27]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_7__0_ ( .D(n211), .CP(w_clk), .CDN(n476), .Q(my_fifo_dual_ram_mem[32]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_7__1_ ( .D(n210), .CP(w_clk), .CDN(n482), .Q(my_fifo_dual_ram_mem[33]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_7__2_ ( .D(n209), .CP(w_clk), .CDN(n482), .Q(my_fifo_dual_ram_mem[34]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_7__3_ ( .D(n208), .CP(w_clk), .CDN(n482), .Q(my_fifo_dual_ram_mem[35]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_5__0_ ( .D(n203), .CP(w_clk), .CDN(n482), .Q(my_fifo_dual_ram_mem[40]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_5__1_ ( .D(n202), .CP(w_clk), .CDN(n482), .Q(my_fifo_dual_ram_mem[41]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_5__2_ ( .D(n201), .CP(w_clk), .CDN(n478), .Q(my_fifo_dual_ram_mem[42]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_5__3_ ( .D(n200), .CP(w_clk), .CDN(n477), .Q(my_fifo_dual_ram_mem[43]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_3__0_ ( .D(n195), .CP(w_clk), .CDN(n476), .Q(my_fifo_dual_ram_mem[48]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_3__1_ ( .D(n194), .CP(w_clk), .CDN(n482), .Q(my_fifo_dual_ram_mem[49]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_3__2_ ( .D(n193), .CP(w_clk), .CDN(n482), .Q(my_fifo_dual_ram_mem[50]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_3__3_ ( .D(n192), .CP(w_clk), .CDN(n478), .Q(my_fifo_dual_ram_mem[51]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_1__0_ ( .D(n187), .CP(w_clk), .CDN(n477), .Q(my_fifo_dual_ram_mem[56]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_1__1_ ( .D(n186), .CP(w_clk), .CDN(n476), .Q(my_fifo_dual_ram_mem[57]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_1__2_ ( .D(n185), .CP(w_clk), .CDN(n482), .Q(my_fifo_dual_ram_mem[58]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_1__3_ ( .D(n184), .CP(w_clk), .CDN(n481), .Q(my_fifo_dual_ram_mem[59]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_14__0_ ( .D(n239), .CP(w_clk), .CDN(
        n481), .Q(my_fifo_dual_ram_mem[4]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_14__1_ ( .D(n238), .CP(w_clk), .CDN(
        n481), .Q(my_fifo_dual_ram_mem[5]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_14__2_ ( .D(n237), .CP(w_clk), .CDN(
        n481), .Q(my_fifo_dual_ram_mem[6]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_14__3_ ( .D(n236), .CP(w_clk), .CDN(
        n481), .Q(my_fifo_dual_ram_mem[7]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_12__0_ ( .D(n231), .CP(w_clk), .CDN(
        n481), .Q(my_fifo_dual_ram_mem[12]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_12__1_ ( .D(n230), .CP(w_clk), .CDN(
        n481), .Q(my_fifo_dual_ram_mem[13]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_12__2_ ( .D(n229), .CP(w_clk), .CDN(
        n479), .Q(my_fifo_dual_ram_mem[14]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_12__3_ ( .D(n228), .CP(w_clk), .CDN(
        n474), .Q(my_fifo_dual_ram_mem[15]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_10__0_ ( .D(n223), .CP(w_clk), .CDN(
        n479), .Q(my_fifo_dual_ram_mem[20]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_10__1_ ( .D(n222), .CP(w_clk), .CDN(
        n479), .Q(my_fifo_dual_ram_mem[21]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_10__2_ ( .D(n221), .CP(w_clk), .CDN(
        n474), .Q(my_fifo_dual_ram_mem[22]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_10__3_ ( .D(n220), .CP(w_clk), .CDN(
        n480), .Q(my_fifo_dual_ram_mem[23]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_8__0_ ( .D(n215), .CP(w_clk), .CDN(n480), .Q(my_fifo_dual_ram_mem[28]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_8__1_ ( .D(n214), .CP(w_clk), .CDN(n475), .Q(my_fifo_dual_ram_mem[29]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_8__2_ ( .D(n213), .CP(w_clk), .CDN(n480), .Q(my_fifo_dual_ram_mem[30]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_8__3_ ( .D(n212), .CP(w_clk), .CDN(
        w_rstn), .Q(my_fifo_dual_ram_mem[31]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_6__0_ ( .D(n207), .CP(w_clk), .CDN(n475), .Q(my_fifo_dual_ram_mem[36]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_6__1_ ( .D(n206), .CP(w_clk), .CDN(n475), .Q(my_fifo_dual_ram_mem[37]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_6__2_ ( .D(n205), .CP(w_clk), .CDN(n480), .Q(my_fifo_dual_ram_mem[38]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_6__3_ ( .D(n204), .CP(w_clk), .CDN(n474), .Q(my_fifo_dual_ram_mem[39]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_4__0_ ( .D(n199), .CP(w_clk), .CDN(n474), .Q(my_fifo_dual_ram_mem[44]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_4__1_ ( .D(n198), .CP(w_clk), .CDN(n481), .Q(my_fifo_dual_ram_mem[45]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_4__2_ ( .D(n197), .CP(w_clk), .CDN(n475), .Q(my_fifo_dual_ram_mem[46]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_4__3_ ( .D(n196), .CP(w_clk), .CDN(n474), .Q(my_fifo_dual_ram_mem[47]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_2__0_ ( .D(n191), .CP(w_clk), .CDN(n481), .Q(my_fifo_dual_ram_mem[52]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_2__1_ ( .D(n190), .CP(w_clk), .CDN(n475), .Q(my_fifo_dual_ram_mem[53]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_2__2_ ( .D(n189), .CP(w_clk), .CDN(n479), .Q(my_fifo_dual_ram_mem[54]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_2__3_ ( .D(n188), .CP(w_clk), .CDN(n475), .Q(my_fifo_dual_ram_mem[55]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_0__0_ ( .D(n183), .CP(w_clk), .CDN(n475), .Q(my_fifo_dual_ram_mem[60]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_0__1_ ( .D(n182), .CP(w_clk), .CDN(n475), .Q(my_fifo_dual_ram_mem[61]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_0__2_ ( .D(n181), .CP(w_clk), .CDN(n475), .Q(my_fifo_dual_ram_mem[62]) );
  DFCNQD1GHVT my_fifo_dual_ram_mem_reg_0__3_ ( .D(n180), .CP(w_clk), .CDN(n475), .Q(my_fifo_dual_ram_mem[63]) );
  DFCNQD1GHVT my_fifo_dual_ram_rd_data_reg_3_ ( .D(n179), .CP(r_clk), .CDN(
        n475), .Q(rd_data[3]) );
  DFCNQD1GHVT my_fifo_dual_ram_rd_data_reg_2_ ( .D(n178), .CP(r_clk), .CDN(
        n474), .Q(rd_data[2]) );
  DFCNQD1GHVT my_config_state_reg ( .D(my_config_next_state), .CP(r_clk), 
        .CDN(n473), .Q(my_config_state) );
  DFCNQD1GHVT my_fifo_dual_ram_rd_data_reg_1_ ( .D(n177), .CP(r_clk), .CDN(
        n475), .Q(rd_data[1]) );
  DFCNQD1GHVT my_config_w_select_reg_1_ ( .D(rd_data[1]), .CP(r_clk), .CDN(
        r_rstn), .Q(my_config_w_select_1_) );
  DFCNQD1GHVT my_fifo_dual_ram_rd_data_reg_0_ ( .D(n176), .CP(r_clk), .CDN(
        n476), .Q(rd_data[0]) );
  DFCNQD1GHVT my_jtag_SCF_reg_0_ ( .D(n261), .CP(w_clk), .CDN(n480), .Q(
        wr_data[0]) );
  DFCNQD1GHVT my_config_w0_reg_0_ ( .D(n175), .CP(r_clk), .CDN(r_rstn), .Q(
        w0[0]) );
  DFCNQD1GHVT my_config_fir_open_reg ( .D(my_config_N12), .CP(r_clk), .CDN(
        n472), .Q(fir_open) );
  DFCNQD1GHVT my_config_w1_reg_0_ ( .D(n171), .CP(r_clk), .CDN(r_rstn), .Q(
        w1[0]) );
  DFCNQD1GHVT my_config_w0_reg_2_ ( .D(n173), .CP(r_clk), .CDN(n472), .Q(w0[2]) );
  DFCNQD1GHVT my_config_w0_reg_3_ ( .D(n172), .CP(r_clk), .CDN(r_rstn), .Q(
        w0[3]) );
  DFCNQD1GHVT my_config_w1_reg_2_ ( .D(n169), .CP(r_clk), .CDN(r_rstn), .Q(
        w1[2]) );
  DFCNQD1GHVT my_config_w1_reg_3_ ( .D(n168), .CP(r_clk), .CDN(n473), .Q(w1[3]) );
  DFCNQD1GHVT my_config_w0_reg_1_ ( .D(n174), .CP(r_clk), .CDN(n473), .Q(w0[1]) );
  DFCNQD1GHVT my_config_w1_reg_1_ ( .D(n170), .CP(r_clk), .CDN(r_rstn), .Q(
        w1[1]) );
  DFSND1GHVT my_jtag_tap_state_reg_3_ ( .D(my_jtag_tap_next_state[3]), .CP(
        w_clk), .SDN(w_rstn), .Q(my_jtag_state[3]), .QN(n483) );
  DFSND1GHVT my_jtag_tap_state_reg_1_ ( .D(my_jtag_tap_next_state[1]), .CP(
        w_clk), .SDN(w_rstn), .Q(my_jtag_state[1]), .QN(n485) );
  DFSND1GHVT my_jtag_tap_state_reg_0_ ( .D(my_jtag_tap_next_state[0]), .CP(
        w_clk), .SDN(w_rstn), .Q(my_jtag_state[0]), .QN(n484) );
  DFCSNQD1GHVT my_jtag_tap_state_reg_2_ ( .D(my_jtag_tap_next_state[2]), .CP(
        w_clk), .CDN(1'b1), .SDN(w_rstn), .Q(my_jtag_state[2]) );
  BUFTD0GHVT my_jtag_tdo_tri ( .I(my_jtag_tdo_o), .OE(n470), .Z(tdo) );
  OR2D0GHVT U282 ( .A1(my_jtag_IR[0]), .A2(my_jtag_state[3]), .Z(n298) );
  NR2D0GHVT U283 ( .A1(my_jtag_N92), .A2(n298), .ZN(n407) );
  NR2D0GHVT U284 ( .A1(my_jtag_N92), .A2(n483), .ZN(n443) );
  NR2D0GHVT U285 ( .A1(my_jtag_state[0]), .A2(n485), .ZN(n310) );
  INVD0GHVT U286 ( .I(my_jtag_state[2]), .ZN(n309) );
  ND3D0GHVT U287 ( .A1(my_jtag_state[2]), .A2(my_jtag_state[0]), .A3(
        my_jtag_state[3]), .ZN(n445) );
  NR2D0GHVT U288 ( .A1(my_jtag_state[1]), .A2(n445), .ZN(n444) );
  ND2D0GHVT U289 ( .A1(n409), .A2(n408), .ZN(n260) );
  AOI22D0GHVT U290 ( .A1(my_jtag_SIR[0]), .A2(n443), .B1(my_jtag_tdo_o), .B2(
        my_jtag_N92), .ZN(n409) );
  ND2D0GHVT U291 ( .A1(n310), .A2(n309), .ZN(my_jtag_N92) );
  AOI22D0GHVT U292 ( .A1(my_fifo_wr_ptr[3]), .A2(my_fifo_rdsync_ptr[3]), .B1(
        my_fifo_wr_ptr[4]), .B2(my_fifo_rdsync_ptr[4]), .ZN(n271) );
  INVD0GHVT U293 ( .I(n390), .ZN(n396) );
  INVD0GHVT U294 ( .I(n446), .ZN(n395) );
  ND2D0GHVT U295 ( .A1(my_fifo_rd_addr[3]), .A2(my_fifo_rd_addr[2]), .ZN(n397)
         );
  AOI22D0GHVT U296 ( .A1(my_fifo_dual_ram_mem[48]), .A2(n406), .B1(
        my_fifo_dual_ram_mem[60]), .B2(n396), .ZN(n374) );
  OAI22D0GHVT U297 ( .A1(n380), .A2(n446), .B1(n379), .B2(n449), .ZN(n387) );
  AOI211D0GHVT U298 ( .A1(my_jtag_state[2]), .A2(my_jtag_state[3]), .B(n484), 
        .C(n485), .ZN(n312) );
  INVD0GHVT U299 ( .I(n428), .ZN(n429) );
  INVD0GHVT U300 ( .I(rd_data[3]), .ZN(n432) );
  INVD0GHVT U301 ( .I(n464), .ZN(n292) );
  INVD0GHVT U302 ( .I(my_fifo_dual_ram_mem[57]), .ZN(n354) );
  INVD0GHVT U303 ( .I(my_fifo_dual_ram_mem[33]), .ZN(n348) );
  INVD0GHVT U304 ( .I(my_fifo_wr_addr[0]), .ZN(n438) );
  ND2D0GHVT U305 ( .A1(my_fifo_rd_addr[0]), .A2(n447), .ZN(n449) );
  OAI22D0GHVT U306 ( .A1(my_jtag_state[1]), .A2(n311), .B1(n310), .B2(n309), 
        .ZN(my_jtag_tap_next_state[2]) );
  OAI22D0GHVT U307 ( .A1(n308), .A2(n425), .B1(n282), .B2(n306), .ZN(n261) );
  AOI22D0GHVT U308 ( .A1(n466), .A2(n425), .B1(n355), .B2(n294), .ZN(n190) );
  MAOI22D0GHVT U309 ( .A1(n459), .A2(n426), .B1(my_fifo_dual_ram_mem[23]), 
        .B2(n459), .ZN(n220) );
  AOI22D0GHVT U310 ( .A1(n467), .A2(n427), .B1(n334), .B2(n291), .ZN(n185) );
  MAOI22D0GHVT U311 ( .A1(n418), .A2(n426), .B1(my_fifo_dual_ram_mem[27]), 
        .B2(n418), .ZN(n216) );
  MAOI22D0GHVT U312 ( .A1(n455), .A2(n427), .B1(my_fifo_dual_ram_mem[2]), .B2(
        n455), .ZN(n241) );
  MAOI22D0GHVT U313 ( .A1(my_fifo_rd_ctrl_rd_gray[4]), .A2(my_fifo_rd_addr[3]), 
        .B1(my_fifo_rd_addr[3]), .B2(my_fifo_rd_ctrl_rd_gray[4]), .ZN(
        my_fifo_rd_ctrl_rd_gray[3]) );
  BUFFD0GHVT U315 ( .I(w_rstn), .Z(n482) );
  BUFFD0GHVT U316 ( .I(w_rstn), .Z(n481) );
  ND2D0GHVT U317 ( .A1(my_jtag_IR[1]), .A2(n407), .ZN(n308) );
  INVD0GHVT U318 ( .I(my_jtag_SftCnt[0]), .ZN(n280) );
  NR2D0GHVT U319 ( .A1(n308), .A2(n280), .ZN(n285) );
  ND2D0GHVT U320 ( .A1(n285), .A2(my_jtag_SftCnt[1]), .ZN(n283) );
  INVD0GHVT U321 ( .I(my_fifo_wr_ptr[1]), .ZN(n267) );
  MUX2ND0GHVT U322 ( .I0(n267), .I1(my_fifo_wr_ptr[1]), .S(
        my_fifo_rdsync_ptr[1]), .ZN(n274) );
  INVD0GHVT U323 ( .I(my_fifo_wr_ptr[0]), .ZN(n270) );
  INVD0GHVT U324 ( .I(my_fifo_wr_ptr[2]), .ZN(n269) );
  AOI22D0GHVT U325 ( .A1(my_fifo_rdsync_ptr[0]), .A2(n270), .B1(
        my_fifo_rdsync_ptr[2]), .B2(n269), .ZN(n268) );
  OAI221D0GHVT U326 ( .A1(n270), .A2(my_fifo_rdsync_ptr[0]), .B1(n269), .B2(
        my_fifo_rdsync_ptr[2]), .C(n268), .ZN(n273) );
  OAI221D0GHVT U327 ( .A1(my_fifo_wr_ptr[3]), .A2(my_fifo_rdsync_ptr[3]), .B1(
        my_fifo_wr_ptr[4]), .B2(my_fifo_rdsync_ptr[4]), .C(n271), .ZN(n272) );
  OAI31D0GHVT U328 ( .A1(n274), .A2(n273), .A3(n272), .B(my_jtag_sync), .ZN(
        n275) );
  OR2D0GHVT U329 ( .A1(n283), .A2(n275), .Z(n410) );
  NR2D0GHVT U330 ( .A1(n438), .A2(n410), .ZN(n286) );
  INVD0GHVT U331 ( .I(n286), .ZN(n411) );
  ND2D0GHVT U332 ( .A1(my_fifo_wr_addr[1]), .A2(my_fifo_wr_addr[2]), .ZN(n424)
         );
  NR2D0GHVT U333 ( .A1(n411), .A2(n424), .ZN(n412) );
  ND2D0GHVT U334 ( .A1(my_fifo_wr_addr[3]), .A2(n412), .ZN(n456) );
  MUX2D0GHVT U335 ( .I0(wr_data[0]), .I1(my_fifo_dual_ram_mem[0]), .S(n456), 
        .Z(n243) );
  INVD0GHVT U336 ( .I(my_fifo_wr_addr[1]), .ZN(n439) );
  INVD0GHVT U337 ( .I(my_fifo_wr_addr[2]), .ZN(n454) );
  ND2D0GHVT U338 ( .A1(n439), .A2(n454), .ZN(n422) );
  INVD0GHVT U339 ( .I(my_fifo_wr_addr[3]), .ZN(n440) );
  NR2D0GHVT U340 ( .A1(n440), .A2(n411), .ZN(n276) );
  IND2D0GHVT U341 ( .A1(n422), .B1(n276), .ZN(n415) );
  MUX2D0GHVT U342 ( .I0(wr_data[0]), .I1(my_fifo_dual_ram_mem[24]), .S(n415), 
        .Z(n219) );
  ND2D0GHVT U343 ( .A1(n454), .A2(my_fifo_wr_addr[1]), .ZN(n421) );
  IND2D0GHVT U344 ( .A1(n421), .B1(n276), .ZN(n413) );
  MUX2D0GHVT U345 ( .I0(wr_data[0]), .I1(my_fifo_dual_ram_mem[16]), .S(n413), 
        .Z(n227) );
  ND2D0GHVT U346 ( .A1(n439), .A2(my_fifo_wr_addr[2]), .ZN(n420) );
  IND2D0GHVT U347 ( .A1(n420), .B1(n276), .ZN(n416) );
  MUX2D0GHVT U348 ( .I0(wr_data[0]), .I1(my_fifo_dual_ram_mem[8]), .S(n416), 
        .Z(n235) );
  ND4D0GHVT U349 ( .A1(wr_data[0]), .A2(wr_data[1]), .A3(wr_data[2]), .A4(
        wr_data[3]), .ZN(n277) );
  INVD0GHVT U350 ( .I(my_jtag_sync), .ZN(n278) );
  NR2D0GHVT U351 ( .A1(n485), .A2(n445), .ZN(n281) );
  AOI221D0GHVT U352 ( .A1(desync), .A2(n277), .B1(n278), .B2(n277), .C(n281), 
        .ZN(n256) );
  ND2D0GHVT U353 ( .A1(my_config_state), .A2(my_config_w_select_1_), .ZN(n428)
         );
  MUX2D0GHVT U354 ( .I0(rd_data[0]), .I1(w1[0]), .S(n428), .Z(n171) );
  INVD0GHVT U355 ( .I(my_config_state), .ZN(n313) );
  NR2D0GHVT U356 ( .A1(my_config_w_select_1_), .A2(n313), .ZN(n434) );
  MUX2D0GHVT U357 ( .I0(w0[0]), .I1(rd_data[0]), .S(n434), .Z(n175) );
  ND2D0GHVT U358 ( .A1(n420), .A2(n421), .ZN(my_fifo_wr_ctrl_wr_gray[1]) );
  NR2D0GHVT U359 ( .A1(n281), .A2(n278), .ZN(n284) );
  INVD0GHVT U360 ( .I(n284), .ZN(n279) );
  AOI211D0GHVT U361 ( .A1(n308), .A2(n280), .B(n285), .C(n279), .ZN(n254) );
  INVD0GHVT U362 ( .I(wr_data[1]), .ZN(n425) );
  INVD0GHVT U363 ( .I(wr_data[0]), .ZN(n282) );
  IND2D0GHVT U364 ( .A1(n281), .B1(n308), .ZN(n306) );
  INVD0GHVT U365 ( .I(wr_data[2]), .ZN(n427) );
  OAI22D0GHVT U366 ( .A1(n308), .A2(n427), .B1(n425), .B2(n306), .ZN(n259) );
  INVD0GHVT U367 ( .I(wr_data[3]), .ZN(n426) );
  OAI22D0GHVT U368 ( .A1(n308), .A2(n426), .B1(n427), .B2(n306), .ZN(n258) );
  OA211D0GHVT U369 ( .A1(n285), .A2(my_jtag_SftCnt[1]), .B(n284), .C(n283), 
        .Z(n255) );
  ND2D0GHVT U370 ( .A1(n286), .A2(n440), .ZN(n288) );
  NR2D0GHVT U371 ( .A1(n424), .A2(n288), .ZN(n461) );
  INVD0GHVT U372 ( .I(n461), .ZN(n290) );
  AOI22D0GHVT U373 ( .A1(n461), .A2(n425), .B1(n348), .B2(n290), .ZN(n210) );
  NR2D0GHVT U374 ( .A1(n421), .A2(n288), .ZN(n465) );
  INVD0GHVT U375 ( .I(my_fifo_dual_ram_mem[49]), .ZN(n357) );
  INVD0GHVT U376 ( .I(n465), .ZN(n287) );
  AOI22D0GHVT U377 ( .A1(n465), .A2(n425), .B1(n357), .B2(n287), .ZN(n194) );
  INVD0GHVT U378 ( .I(my_fifo_dual_ram_mem[50]), .ZN(n337) );
  AOI22D0GHVT U379 ( .A1(n465), .A2(n427), .B1(n337), .B2(n287), .ZN(n193) );
  INVD0GHVT U380 ( .I(my_fifo_dual_ram_mem[51]), .ZN(n393) );
  AOI22D0GHVT U381 ( .A1(n465), .A2(n426), .B1(n393), .B2(n287), .ZN(n192) );
  NR2D0GHVT U382 ( .A1(n422), .A2(n288), .ZN(n467) );
  INVD0GHVT U383 ( .I(n467), .ZN(n291) );
  AOI22D0GHVT U384 ( .A1(n467), .A2(n425), .B1(n354), .B2(n291), .ZN(n186) );
  INVD0GHVT U385 ( .I(my_fifo_dual_ram_mem[58]), .ZN(n334) );
  NR2D0GHVT U386 ( .A1(n420), .A2(n288), .ZN(n463) );
  INVD0GHVT U387 ( .I(my_fifo_dual_ram_mem[41]), .ZN(n345) );
  INVD0GHVT U388 ( .I(n463), .ZN(n289) );
  AOI22D0GHVT U389 ( .A1(n463), .A2(n425), .B1(n345), .B2(n289), .ZN(n202) );
  INVD0GHVT U390 ( .I(my_fifo_dual_ram_mem[42]), .ZN(n324) );
  AOI22D0GHVT U391 ( .A1(n463), .A2(n427), .B1(n324), .B2(n289), .ZN(n201) );
  INVD0GHVT U392 ( .I(my_fifo_dual_ram_mem[43]), .ZN(n379) );
  AOI22D0GHVT U393 ( .A1(n463), .A2(n426), .B1(n379), .B2(n289), .ZN(n200) );
  INVD0GHVT U394 ( .I(my_fifo_dual_ram_mem[34]), .ZN(n328) );
  AOI22D0GHVT U395 ( .A1(n461), .A2(n427), .B1(n328), .B2(n290), .ZN(n209) );
  INVD0GHVT U396 ( .I(my_fifo_dual_ram_mem[35]), .ZN(n382) );
  AOI22D0GHVT U397 ( .A1(n461), .A2(n426), .B1(n382), .B2(n290), .ZN(n208) );
  INVD0GHVT U398 ( .I(my_fifo_dual_ram_mem[59]), .ZN(n388) );
  AOI22D0GHVT U399 ( .A1(n467), .A2(n426), .B1(n388), .B2(n291), .ZN(n184) );
  NR2D0GHVT U400 ( .A1(my_fifo_wr_addr[0]), .A2(n410), .ZN(n419) );
  ND2D0GHVT U401 ( .A1(n419), .A2(n440), .ZN(n293) );
  NR2D0GHVT U402 ( .A1(n422), .A2(n293), .ZN(n468) );
  INVD0GHVT U403 ( .I(my_fifo_dual_ram_mem[63]), .ZN(n391) );
  INVD0GHVT U404 ( .I(n468), .ZN(n296) );
  AOI22D0GHVT U405 ( .A1(n468), .A2(n426), .B1(n391), .B2(n296), .ZN(n180) );
  NR2D0GHVT U406 ( .A1(n420), .A2(n293), .ZN(n464) );
  INVD0GHVT U407 ( .I(my_fifo_dual_ram_mem[45]), .ZN(n347) );
  AOI22D0GHVT U408 ( .A1(n464), .A2(n425), .B1(n347), .B2(n292), .ZN(n198) );
  INVD0GHVT U409 ( .I(my_fifo_dual_ram_mem[46]), .ZN(n327) );
  AOI22D0GHVT U410 ( .A1(n464), .A2(n427), .B1(n327), .B2(n292), .ZN(n197) );
  INVD0GHVT U411 ( .I(my_fifo_dual_ram_mem[47]), .ZN(n381) );
  AOI22D0GHVT U412 ( .A1(n464), .A2(n426), .B1(n381), .B2(n292), .ZN(n196) );
  NR2D0GHVT U413 ( .A1(n424), .A2(n293), .ZN(n462) );
  INVD0GHVT U414 ( .I(my_fifo_dual_ram_mem[39]), .ZN(n380) );
  INVD0GHVT U415 ( .I(n462), .ZN(n295) );
  AOI22D0GHVT U416 ( .A1(n462), .A2(n426), .B1(n380), .B2(n295), .ZN(n204) );
  NR2D0GHVT U417 ( .A1(n421), .A2(n293), .ZN(n466) );
  INVD0GHVT U418 ( .I(my_fifo_dual_ram_mem[53]), .ZN(n355) );
  INVD0GHVT U419 ( .I(n466), .ZN(n294) );
  INVD0GHVT U420 ( .I(my_fifo_dual_ram_mem[38]), .ZN(n325) );
  AOI22D0GHVT U421 ( .A1(n462), .A2(n427), .B1(n325), .B2(n295), .ZN(n205) );
  INVD0GHVT U422 ( .I(my_fifo_dual_ram_mem[55]), .ZN(n389) );
  AOI22D0GHVT U423 ( .A1(n466), .A2(n426), .B1(n389), .B2(n294), .ZN(n188) );
  INVD0GHVT U424 ( .I(my_fifo_dual_ram_mem[54]), .ZN(n335) );
  AOI22D0GHVT U425 ( .A1(n466), .A2(n427), .B1(n335), .B2(n294), .ZN(n189) );
  INVD0GHVT U426 ( .I(my_fifo_dual_ram_mem[61]), .ZN(n356) );
  AOI22D0GHVT U427 ( .A1(n468), .A2(n425), .B1(n356), .B2(n296), .ZN(n182) );
  INVD0GHVT U428 ( .I(my_fifo_dual_ram_mem[37]), .ZN(n346) );
  AOI22D0GHVT U429 ( .A1(n462), .A2(n425), .B1(n346), .B2(n295), .ZN(n206) );
  INVD0GHVT U430 ( .I(my_fifo_dual_ram_mem[62]), .ZN(n336) );
  AOI22D0GHVT U431 ( .A1(n468), .A2(n427), .B1(n336), .B2(n296), .ZN(n181) );
  ND2D0GHVT U432 ( .A1(my_jtag_state[2]), .A2(n485), .ZN(n302) );
  INVD0GHVT U433 ( .I(n302), .ZN(n297) );
  ND2D0GHVT U434 ( .A1(n484), .A2(n483), .ZN(n305) );
  AOI32D0GHVT U435 ( .A1(tms), .A2(n297), .A3(n305), .B1(n483), .B2(n302), 
        .ZN(my_jtag_tap_next_state[3]) );
  ND2D0GHVT U436 ( .A1(n407), .A2(n471), .ZN(n301) );
  INVD0GHVT U437 ( .I(tdi), .ZN(n307) );
  NR2D0GHVT U438 ( .A1(my_jtag_IR[1]), .A2(n298), .ZN(n299) );
  ND2D0GHVT U439 ( .A1(n310), .A2(n299), .ZN(n300) );
  MOAI22D0GHVT U440 ( .A1(n301), .A2(n307), .B1(my_jtag_BypReg), .B2(n300), 
        .ZN(n262) );
  ND2D0GHVT U441 ( .A1(n445), .A2(n302), .ZN(n304) );
  INVD0GHVT U442 ( .I(tms), .ZN(n311) );
  INVD0GHVT U443 ( .I(n304), .ZN(n303) );
  AOI32D0GHVT U444 ( .A1(n305), .A2(n304), .A3(n311), .B1(tms), .B2(n303), 
        .ZN(my_jtag_tap_next_state[1]) );
  OAI22D0GHVT U445 ( .A1(n308), .A2(n307), .B1(n426), .B2(n306), .ZN(n257) );
  OAI32D0GHVT U446 ( .A1(tms), .A2(my_jtag_state[2]), .A3(n484), .B1(n312), 
        .B2(n311), .ZN(my_jtag_tap_next_state[0]) );
  INVD0GHVT U447 ( .I(my_fifo_rd_addr[1]), .ZN(n447) );
  INVD0GHVT U448 ( .I(my_fifo_rd_addr[2]), .ZN(n437) );
  AOI22D0GHVT U449 ( .A1(my_fifo_rd_addr[2]), .A2(my_fifo_rd_addr[1]), .B1(
        n447), .B2(n437), .ZN(my_fifo_rd_ctrl_rd_gray[1]) );
  INVD0GHVT U450 ( .I(my_fifo_rd_addr[0]), .ZN(n326) );
  ND2D0GHVT U451 ( .A1(my_fifo_rd_addr[1]), .A2(n326), .ZN(n446) );
  ND2D0GHVT U452 ( .A1(n449), .A2(n446), .ZN(my_fifo_rd_ctrl_rd_gray[0]) );
  INVD0GHVT U453 ( .I(rd_data[2]), .ZN(n441) );
  OA211D0GHVT U454 ( .A1(rd_data[3]), .A2(fir_open), .B(n313), .C(n441), .Z(
        my_config_N12) );
  INVD0GHVT U455 ( .I(my_fifo_rd_ptr[1]), .ZN(n323) );
  INVD0GHVT U456 ( .I(my_fifo_rd_ptr[0]), .ZN(n316) );
  INVD0GHVT U457 ( .I(my_fifo_rd_ptr[3]), .ZN(n315) );
  OAI22D0GHVT U458 ( .A1(n316), .A2(my_fifo_wrsync_ptr[0]), .B1(n315), .B2(
        my_fifo_wrsync_ptr[3]), .ZN(n314) );
  AOI221D0GHVT U459 ( .A1(n316), .A2(my_fifo_wrsync_ptr[0]), .B1(
        my_fifo_wrsync_ptr[3]), .B2(n315), .C(n314), .ZN(n322) );
  INVD0GHVT U460 ( .I(my_fifo_rd_ptr[4]), .ZN(n319) );
  INVD0GHVT U461 ( .I(my_fifo_rd_ptr[2]), .ZN(n318) );
  AOI22D0GHVT U462 ( .A1(my_fifo_wrsync_ptr[4]), .A2(n319), .B1(
        my_fifo_wrsync_ptr[2]), .B2(n318), .ZN(n317) );
  OAI221D0GHVT U463 ( .A1(n319), .A2(my_fifo_wrsync_ptr[4]), .B1(n318), .B2(
        my_fifo_wrsync_ptr[2]), .C(n317), .ZN(n320) );
  AOI21D0GHVT U464 ( .A1(my_fifo_wrsync_ptr[1]), .A2(n323), .B(n320), .ZN(n321) );
  OAI211D0GHVT U465 ( .A1(my_fifo_wrsync_ptr[1]), .A2(n323), .B(n322), .C(n321), .ZN(n448) );
  INVD0GHVT U466 ( .I(n448), .ZN(n450) );
  AOI22D0GHVT U467 ( .A1(my_fifo_rd_addr[0]), .A2(n448), .B1(n450), .B2(n326), 
        .ZN(n253) );
  OAI22D0GHVT U468 ( .A1(n325), .A2(n446), .B1(n324), .B2(n449), .ZN(n333) );
  NR2D0GHVT U469 ( .A1(my_fifo_rd_addr[3]), .A2(n437), .ZN(n431) );
  NR2D0GHVT U470 ( .A1(n326), .A2(n447), .ZN(n406) );
  INVD0GHVT U471 ( .I(n406), .ZN(n392) );
  ND2D0GHVT U472 ( .A1(n326), .A2(n447), .ZN(n390) );
  OAI22D0GHVT U473 ( .A1(n328), .A2(n392), .B1(n327), .B2(n390), .ZN(n332) );
  INVD0GHVT U474 ( .I(n449), .ZN(n394) );
  AOI22D0GHVT U475 ( .A1(my_fifo_dual_ram_mem[22]), .A2(n395), .B1(
        my_fifo_dual_ram_mem[26]), .B2(n394), .ZN(n330) );
  AOI22D0GHVT U476 ( .A1(my_fifo_dual_ram_mem[18]), .A2(n406), .B1(
        my_fifo_dual_ram_mem[30]), .B2(n396), .ZN(n329) );
  ND2D0GHVT U477 ( .A1(my_fifo_rd_addr[3]), .A2(n437), .ZN(n430) );
  AOI21D0GHVT U478 ( .A1(n330), .A2(n329), .B(n430), .ZN(n331) );
  AOI221D0GHVT U479 ( .A1(n333), .A2(n431), .B1(n332), .B2(n431), .C(n331), 
        .ZN(n344) );
  OAI22D0GHVT U480 ( .A1(n335), .A2(n446), .B1(n334), .B2(n449), .ZN(n342) );
  NR2D0GHVT U481 ( .A1(my_fifo_rd_addr[3]), .A2(my_fifo_rd_addr[2]), .ZN(n402)
         );
  OAI22D0GHVT U482 ( .A1(n337), .A2(n392), .B1(n336), .B2(n390), .ZN(n341) );
  AOI22D0GHVT U483 ( .A1(my_fifo_dual_ram_mem[6]), .A2(n395), .B1(
        my_fifo_dual_ram_mem[10]), .B2(n394), .ZN(n339) );
  AOI22D0GHVT U484 ( .A1(my_fifo_dual_ram_mem[2]), .A2(n406), .B1(
        my_fifo_dual_ram_mem[14]), .B2(n396), .ZN(n338) );
  AOI21D0GHVT U485 ( .A1(n339), .A2(n338), .B(n397), .ZN(n340) );
  AOI221D0GHVT U486 ( .A1(n342), .A2(n402), .B1(n341), .B2(n402), .C(n340), 
        .ZN(n343) );
  AOI32D0GHVT U487 ( .A1(n344), .A2(n448), .A3(n343), .B1(n450), .B2(n441), 
        .ZN(n178) );
  OAI22D0GHVT U488 ( .A1(n346), .A2(n446), .B1(n345), .B2(n449), .ZN(n353) );
  OAI22D0GHVT U489 ( .A1(n348), .A2(n392), .B1(n347), .B2(n390), .ZN(n352) );
  AOI22D0GHVT U490 ( .A1(my_fifo_dual_ram_mem[21]), .A2(n395), .B1(
        my_fifo_dual_ram_mem[25]), .B2(n394), .ZN(n350) );
  AOI22D0GHVT U491 ( .A1(my_fifo_dual_ram_mem[17]), .A2(n406), .B1(
        my_fifo_dual_ram_mem[29]), .B2(n396), .ZN(n349) );
  AOI21D0GHVT U492 ( .A1(n350), .A2(n349), .B(n430), .ZN(n351) );
  AOI221D0GHVT U493 ( .A1(n353), .A2(n431), .B1(n352), .B2(n431), .C(n351), 
        .ZN(n364) );
  OAI22D0GHVT U494 ( .A1(n355), .A2(n446), .B1(n354), .B2(n449), .ZN(n362) );
  OAI22D0GHVT U495 ( .A1(n357), .A2(n392), .B1(n356), .B2(n390), .ZN(n361) );
  AOI22D0GHVT U496 ( .A1(my_fifo_dual_ram_mem[5]), .A2(n395), .B1(
        my_fifo_dual_ram_mem[9]), .B2(n394), .ZN(n359) );
  AOI22D0GHVT U497 ( .A1(my_fifo_dual_ram_mem[1]), .A2(n406), .B1(
        my_fifo_dual_ram_mem[13]), .B2(n396), .ZN(n358) );
  AOI21D0GHVT U498 ( .A1(n359), .A2(n358), .B(n397), .ZN(n360) );
  AOI221D0GHVT U499 ( .A1(n362), .A2(n402), .B1(n361), .B2(n402), .C(n360), 
        .ZN(n363) );
  INVD0GHVT U500 ( .I(rd_data[1]), .ZN(n433) );
  AOI32D0GHVT U501 ( .A1(n364), .A2(n448), .A3(n363), .B1(n450), .B2(n433), 
        .ZN(n177) );
  AOI22D0GHVT U502 ( .A1(my_fifo_dual_ram_mem[36]), .A2(n395), .B1(
        my_fifo_dual_ram_mem[40]), .B2(n394), .ZN(n366) );
  AOI22D0GHVT U503 ( .A1(my_fifo_dual_ram_mem[32]), .A2(n406), .B1(
        my_fifo_dual_ram_mem[44]), .B2(n396), .ZN(n365) );
  ND2D0GHVT U504 ( .A1(n366), .A2(n365), .ZN(n373) );
  AOI22D0GHVT U505 ( .A1(my_fifo_dual_ram_mem[20]), .A2(n395), .B1(
        my_fifo_dual_ram_mem[24]), .B2(n394), .ZN(n368) );
  AOI22D0GHVT U506 ( .A1(my_fifo_dual_ram_mem[16]), .A2(n406), .B1(
        my_fifo_dual_ram_mem[28]), .B2(n396), .ZN(n367) );
  AOI21D0GHVT U507 ( .A1(n368), .A2(n367), .B(n430), .ZN(n372) );
  AOI22D0GHVT U508 ( .A1(my_fifo_dual_ram_mem[4]), .A2(n395), .B1(
        my_fifo_dual_ram_mem[8]), .B2(n394), .ZN(n370) );
  AOI22D0GHVT U509 ( .A1(my_fifo_dual_ram_mem[0]), .A2(n406), .B1(
        my_fifo_dual_ram_mem[12]), .B2(n396), .ZN(n369) );
  AOI21D0GHVT U510 ( .A1(n370), .A2(n369), .B(n397), .ZN(n371) );
  AOI211D0GHVT U511 ( .A1(n431), .A2(n373), .B(n372), .C(n371), .ZN(n378) );
  AOI22D0GHVT U512 ( .A1(my_fifo_dual_ram_mem[52]), .A2(n395), .B1(
        my_fifo_dual_ram_mem[56]), .B2(n394), .ZN(n375) );
  IOA21D0GHVT U513 ( .A1(n375), .A2(n374), .B(n402), .ZN(n377) );
  INVD0GHVT U514 ( .I(rd_data[0]), .ZN(n376) );
  AOI32D0GHVT U515 ( .A1(n378), .A2(n448), .A3(n377), .B1(n450), .B2(n376), 
        .ZN(n176) );
  OAI22D0GHVT U516 ( .A1(n382), .A2(n392), .B1(n381), .B2(n390), .ZN(n386) );
  AOI22D0GHVT U517 ( .A1(my_fifo_dual_ram_mem[23]), .A2(n395), .B1(
        my_fifo_dual_ram_mem[27]), .B2(n394), .ZN(n384) );
  AOI22D0GHVT U518 ( .A1(my_fifo_dual_ram_mem[19]), .A2(n406), .B1(
        my_fifo_dual_ram_mem[31]), .B2(n396), .ZN(n383) );
  AOI21D0GHVT U519 ( .A1(n384), .A2(n383), .B(n430), .ZN(n385) );
  AOI221D0GHVT U520 ( .A1(n387), .A2(n431), .B1(n386), .B2(n431), .C(n385), 
        .ZN(n405) );
  OAI22D0GHVT U521 ( .A1(n389), .A2(n446), .B1(n388), .B2(n449), .ZN(n403) );
  OAI22D0GHVT U522 ( .A1(n393), .A2(n392), .B1(n391), .B2(n390), .ZN(n401) );
  AOI22D0GHVT U523 ( .A1(my_fifo_dual_ram_mem[7]), .A2(n395), .B1(
        my_fifo_dual_ram_mem[11]), .B2(n394), .ZN(n399) );
  AOI22D0GHVT U524 ( .A1(my_fifo_dual_ram_mem[3]), .A2(n406), .B1(
        my_fifo_dual_ram_mem[15]), .B2(n396), .ZN(n398) );
  AOI21D0GHVT U525 ( .A1(n399), .A2(n398), .B(n397), .ZN(n400) );
  AOI221D0GHVT U526 ( .A1(n403), .A2(n402), .B1(n401), .B2(n402), .C(n400), 
        .ZN(n404) );
  AOI32D0GHVT U527 ( .A1(n405), .A2(n448), .A3(n404), .B1(n450), .B2(n432), 
        .ZN(n179) );
  ND2D0GHVT U528 ( .A1(n406), .A2(n448), .ZN(n436) );
  NR2D0GHVT U529 ( .A1(n437), .A2(n436), .ZN(n435) );
  ND2D0GHVT U530 ( .A1(my_fifo_rd_addr[3]), .A2(n435), .ZN(n451) );
  OA21D0GHVT U531 ( .A1(my_fifo_rd_addr[3]), .A2(n435), .B(n451), .Z(n250) );
  OAI221D0GHVT U532 ( .A1(my_jtag_IR[1]), .A2(my_jtag_BypReg), .B1(n471), .B2(
        wr_data[0]), .C(n407), .ZN(n408) );
  BUFFD0GHVT U533 ( .I(n482), .Z(n477) );
  BUFFD0GHVT U534 ( .I(n482), .Z(n478) );
  BUFFD0GHVT U535 ( .I(r_rstn), .Z(n473) );
  BUFFD0GHVT U536 ( .I(w_rstn), .Z(n479) );
  BUFFD0GHVT U537 ( .I(n482), .Z(n476) );
  BUFFD0GHVT U538 ( .I(r_rstn), .Z(n472) );
  BUFFD0GHVT U539 ( .I(n481), .Z(n474) );
  BUFFD0GHVT U540 ( .I(w_rstn), .Z(n480) );
  BUFFD0GHVT U541 ( .I(n481), .Z(n475) );
  AO21D0GHVT U542 ( .A1(my_fifo_wr_addr[0]), .A2(n410), .B(n419), .Z(n248) );
  NR2D0GHVT U543 ( .A1(n411), .A2(n439), .ZN(n453) );
  AOI21D0GHVT U544 ( .A1(n411), .A2(n439), .B(n453), .ZN(n247) );
  INVD0GHVT U545 ( .I(n456), .ZN(n455) );
  IAO21D0GHVT U546 ( .A1(my_fifo_wr_addr[3]), .A2(n412), .B(n455), .ZN(n245)
         );
  MAOI22D0GHVT U547 ( .A1(n455), .A2(n425), .B1(my_fifo_dual_ram_mem[1]), .B2(
        n455), .ZN(n242) );
  MAOI22D0GHVT U548 ( .A1(n455), .A2(n426), .B1(my_fifo_dual_ram_mem[3]), .B2(
        n455), .ZN(n240) );
  INVD0GHVT U549 ( .I(n413), .ZN(n414) );
  MAOI22D0GHVT U550 ( .A1(n414), .A2(n425), .B1(my_fifo_dual_ram_mem[17]), 
        .B2(n414), .ZN(n226) );
  MAOI22D0GHVT U551 ( .A1(n414), .A2(n427), .B1(my_fifo_dual_ram_mem[18]), 
        .B2(n414), .ZN(n225) );
  MAOI22D0GHVT U552 ( .A1(n414), .A2(n426), .B1(my_fifo_dual_ram_mem[19]), 
        .B2(n414), .ZN(n224) );
  INVD0GHVT U553 ( .I(n415), .ZN(n418) );
  MAOI22D0GHVT U554 ( .A1(n418), .A2(n425), .B1(my_fifo_dual_ram_mem[25]), 
        .B2(n418), .ZN(n218) );
  INVD0GHVT U555 ( .I(n416), .ZN(n417) );
  MAOI22D0GHVT U556 ( .A1(n417), .A2(n426), .B1(my_fifo_dual_ram_mem[11]), 
        .B2(n417), .ZN(n232) );
  MAOI22D0GHVT U557 ( .A1(n417), .A2(n427), .B1(my_fifo_dual_ram_mem[10]), 
        .B2(n417), .ZN(n233) );
  MAOI22D0GHVT U558 ( .A1(n418), .A2(n427), .B1(my_fifo_dual_ram_mem[26]), 
        .B2(n418), .ZN(n217) );
  MAOI22D0GHVT U559 ( .A1(n417), .A2(n425), .B1(my_fifo_dual_ram_mem[9]), .B2(
        n417), .ZN(n234) );
  ND2D0GHVT U560 ( .A1(my_fifo_wr_addr[3]), .A2(n419), .ZN(n423) );
  NR2D0GHVT U561 ( .A1(n423), .A2(n420), .ZN(n458) );
  MAOI22D0GHVT U562 ( .A1(n458), .A2(n426), .B1(my_fifo_dual_ram_mem[15]), 
        .B2(n458), .ZN(n228) );
  NR2D0GHVT U563 ( .A1(n423), .A2(n421), .ZN(n459) );
  MAOI22D0GHVT U564 ( .A1(n459), .A2(n425), .B1(my_fifo_dual_ram_mem[21]), 
        .B2(n459), .ZN(n222) );
  MAOI22D0GHVT U565 ( .A1(n459), .A2(n427), .B1(my_fifo_dual_ram_mem[22]), 
        .B2(n459), .ZN(n221) );
  MAOI22D0GHVT U566 ( .A1(n458), .A2(n427), .B1(my_fifo_dual_ram_mem[14]), 
        .B2(n458), .ZN(n229) );
  NR2D0GHVT U567 ( .A1(n423), .A2(n422), .ZN(n460) );
  MAOI22D0GHVT U568 ( .A1(n460), .A2(n426), .B1(my_fifo_dual_ram_mem[31]), 
        .B2(n460), .ZN(n212) );
  MAOI22D0GHVT U569 ( .A1(n460), .A2(n427), .B1(my_fifo_dual_ram_mem[30]), 
        .B2(n460), .ZN(n213) );
  MAOI22D0GHVT U570 ( .A1(n460), .A2(n425), .B1(my_fifo_dual_ram_mem[29]), 
        .B2(n460), .ZN(n214) );
  MAOI22D0GHVT U571 ( .A1(n458), .A2(n425), .B1(my_fifo_dual_ram_mem[13]), 
        .B2(n458), .ZN(n230) );
  NR2D0GHVT U572 ( .A1(n424), .A2(n423), .ZN(n457) );
  MAOI22D0GHVT U573 ( .A1(n457), .A2(n425), .B1(my_fifo_dual_ram_mem[5]), .B2(
        n457), .ZN(n238) );
  MAOI22D0GHVT U574 ( .A1(n457), .A2(n426), .B1(my_fifo_dual_ram_mem[7]), .B2(
        n457), .ZN(n236) );
  MAOI22D0GHVT U575 ( .A1(n457), .A2(n427), .B1(my_fifo_dual_ram_mem[6]), .B2(
        n457), .ZN(n237) );
  MAOI22D0GHVT U576 ( .A1(n429), .A2(n432), .B1(w1[3]), .B2(n429), .ZN(n168)
         );
  MAOI22D0GHVT U577 ( .A1(n429), .A2(n441), .B1(w1[2]), .B2(n429), .ZN(n169)
         );
  MAOI22D0GHVT U578 ( .A1(n429), .A2(n433), .B1(w1[1]), .B2(n429), .ZN(n170)
         );
  IND2D0GHVT U579 ( .A1(n431), .B1(n430), .ZN(my_fifo_rd_ctrl_rd_gray[2]) );
  MAOI22D0GHVT U580 ( .A1(n434), .A2(n432), .B1(w0[3]), .B2(n434), .ZN(n172)
         );
  MAOI22D0GHVT U581 ( .A1(n434), .A2(n433), .B1(w0[1]), .B2(n434), .ZN(n174)
         );
  MAOI22D0GHVT U582 ( .A1(n434), .A2(n441), .B1(w0[2]), .B2(n434), .ZN(n173)
         );
  AOI21D0GHVT U583 ( .A1(n437), .A2(n436), .B(n435), .ZN(n251) );
  AOI22D0GHVT U584 ( .A1(my_fifo_wr_addr[0]), .A2(my_fifo_wr_addr[1]), .B1(
        n439), .B2(n438), .ZN(my_fifo_wr_ctrl_wr_gray[0]) );
  AOI22D0GHVT U585 ( .A1(my_fifo_wr_addr[3]), .A2(my_fifo_wr_addr[2]), .B1(
        n454), .B2(n440), .ZN(my_fifo_wr_ctrl_wr_gray[2]) );
  MUX2ND0GHVT U586 ( .I0(n440), .I1(my_fifo_wr_addr[3]), .S(
        my_fifo_wr_ctrl_wr_gray[4]), .ZN(my_fifo_wr_ctrl_wr_gray[3]) );
  NR4D0GHVT U587 ( .A1(n450), .A2(rd_data[3]), .A3(my_config_state), .A4(n441), 
        .ZN(my_config_next_state) );
  OAI211D0GHVT U588 ( .A1(my_jtag_state[2]), .A2(n484), .B(my_jtag_state[1]), 
        .C(my_jtag_state[3]), .ZN(n442) );
  AO22D0GHVT U589 ( .A1(n443), .A2(tdi), .B1(my_jtag_SIR[1]), .B2(n442), .Z(
        n266) );
  AO22D0GHVT U590 ( .A1(n443), .A2(my_jtag_SIR[1]), .B1(my_jtag_SIR[0]), .B2(
        n442), .Z(n265) );
  AO22D0GHVT U591 ( .A1(my_jtag_IR[0]), .A2(n445), .B1(my_jtag_SIR[0]), .B2(
        n444), .Z(n264) );
  AO22D0GHVT U592 ( .A1(my_jtag_IR[1]), .A2(n445), .B1(my_jtag_SIR[1]), .B2(
        n444), .Z(n263) );
  OAI221D0GHVT U593 ( .A1(n450), .A2(n449), .B1(n448), .B2(n447), .C(n446), 
        .ZN(n252) );
  INVD0GHVT U594 ( .I(my_fifo_rd_ctrl_rd_gray[4]), .ZN(n452) );
  MUX2ND0GHVT U595 ( .I0(my_fifo_rd_ctrl_rd_gray[4]), .I1(n452), .S(n451), 
        .ZN(n249) );
  MUX2ND0GHVT U596 ( .I0(n454), .I1(my_fifo_wr_addr[2]), .S(n453), .ZN(n246)
         );
  MUX2ND0GHVT U597 ( .I0(n456), .I1(n455), .S(my_fifo_wr_ctrl_wr_gray[4]), 
        .ZN(n244) );
  MUX2D0GHVT U598 ( .I0(my_fifo_dual_ram_mem[4]), .I1(wr_data[0]), .S(n457), 
        .Z(n239) );
  MUX2D0GHVT U599 ( .I0(my_fifo_dual_ram_mem[12]), .I1(wr_data[0]), .S(n458), 
        .Z(n231) );
  MUX2D0GHVT U600 ( .I0(my_fifo_dual_ram_mem[20]), .I1(wr_data[0]), .S(n459), 
        .Z(n223) );
  MUX2D0GHVT U601 ( .I0(my_fifo_dual_ram_mem[28]), .I1(wr_data[0]), .S(n460), 
        .Z(n215) );
  MUX2D0GHVT U602 ( .I0(my_fifo_dual_ram_mem[32]), .I1(wr_data[0]), .S(n461), 
        .Z(n211) );
  MUX2D0GHVT U603 ( .I0(my_fifo_dual_ram_mem[36]), .I1(wr_data[0]), .S(n462), 
        .Z(n207) );
  MUX2D0GHVT U604 ( .I0(my_fifo_dual_ram_mem[40]), .I1(wr_data[0]), .S(n463), 
        .Z(n203) );
  MUX2D0GHVT U605 ( .I0(my_fifo_dual_ram_mem[44]), .I1(wr_data[0]), .S(n464), 
        .Z(n199) );
  MUX2D0GHVT U606 ( .I0(my_fifo_dual_ram_mem[48]), .I1(wr_data[0]), .S(n465), 
        .Z(n195) );
  MUX2D0GHVT U607 ( .I0(my_fifo_dual_ram_mem[52]), .I1(wr_data[0]), .S(n466), 
        .Z(n191) );
  MUX2D0GHVT U608 ( .I0(my_fifo_dual_ram_mem[56]), .I1(wr_data[0]), .S(n467), 
        .Z(n187) );
  MUX2D0GHVT U609 ( .I0(my_fifo_dual_ram_mem[60]), .I1(wr_data[0]), .S(n468), 
        .Z(n183) );
endmodule

