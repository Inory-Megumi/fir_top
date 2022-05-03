//Date		: 2022/3/29
//Author	: kehongbo
//Function	: fifo_top
module fifo_top #(
    parameter DATA_WIDTH = 4,
    parameter ADDR_WIDTH = 4  
)
(
    input   wr_clk,
    input   wrst_n,
    input   wr_en,
    input   [DATA_WIDTH - 1:0]  wr_data,
    input   rd_clk,
    input   rdst_n,
    input   rd_en,
    output  [DATA_WIDTH - 1:0]  rd_data,
    output  full,
    output  empty
);
//wire and regs
wire [ADDR_WIDTH - 1:0] wr_addr;
wire [ADDR_WIDTH:0]     wr_ptr;
wire [ADDR_WIDTH - 1:0] rd_addr;
wire [ADDR_WIDTH:0]     rd_ptr;
wire[ADDR_WIDTH:0]  rdsync_ptr;
wire[ADDR_WIDTH:0]  wrsync_ptr;

//write controller

wr_controller wr_ctrl
(
    .wr_clk(wr_clk),
    .wrst_n(wrst_n),
    .wr_en(wr_en),
    .rdsync_ptr(rdsync_ptr),
    .wr_ptr(wr_ptr),
    .wr_addr(wr_addr),
    .full(full)
);
//read controller

rd_controller rd_ctrl
(
    .rd_clk(rd_clk),
    .rdst_n(rdst_n),
    .rd_en(rd_en),
    .wrsync_ptr(wrsync_ptr),
    .rd_ptr(rd_ptr),
    .rd_addr(rd_addr),
    .empty(empty)
);
//synchronizer

synchronizer sync_r2w
(
    .cdc_clk(wr_clk),
    .cdc_rstn(wrst_n),
    .input_signal(rd_ptr),
    .output_signal(rdsync_ptr)
);

synchronizer sync_w2r
(
    .cdc_clk(rd_clk),
    .cdc_rstn(rdst_n),
    .input_signal(wr_ptr),
    .output_signal(wrsync_ptr)
);
//dual-port ram
ram dual_ram
(
    .wr_clk(wr_clk),
    .aclear(wrst_n),
    .wr_en(wr_en&~full),
    .wr_addr(wr_addr),
    .wr_data(wr_data),
    .rd_clk(rd_clk),
    .rd_en(rd_en&~empty),
    .rd_addr(rd_addr),
    .rd_data(rd_data)
);
endmodule

