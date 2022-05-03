module fir_top
(
    //jtag
    input w_clk,
    input w_rstn,
    input tms,
    input desync,
    input tdi,
    input r_clk,
    input r_rstn,
    output tdo,
    output [3:0] w0,
    output [3:0] w1,
    output fir_open
);
//jtag
wire wr_en;
wire [3:0] wr_data;
jtag_top my_jtag(w_clk,w_rstn,tms,tdi,desync,tdo,wr_en,wr_data);
//fifo
wire [3:0] rd_data;
wire full, empty;
wire rd_en;
assign rd_en = 1'b1;
fifo_top my_fifo
(
    .wr_clk(w_clk),
    .wrst_n(w_rstn),
    .wr_en(wr_en),
    .wr_data(wr_data),
    .rd_clk(r_clk),
    .rdst_n(r_rstn),
    .rd_en(rd_en),
    .rd_data(rd_data),
    .full(full),
    .empty(empty)
);
//config
config_top my_config(r_clk, r_rstn, rd_data, empty, w0, w1, fir_open);
endmodule