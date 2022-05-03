//Date		: 2022/3/29
//Author	: kehongbo
//Function	: write domain controller
module wr_controller
#(
    parameter ADDR_WIDTH = 4
)
(
    input   wr_clk,
    input   wrst_n,
    input   wr_en,
    input  [ADDR_WIDTH : 0] rdsync_ptr,//rd_ptr after synchronization
    output reg [ADDR_WIDTH : 0] wr_ptr,
    output  [ADDR_WIDTH - 1 : 0] wr_addr,
    output  full
);
reg [ADDR_WIDTH : 0] wr_bin;//attention! bits + 1 
always @(posedge wr_clk, negedge wrst_n)    begin
    if (!wrst_n)
        wr_bin <= 0;
    else if (wr_en && !full) begin
        wr_bin <= wr_bin + 1;
    end
    else begin
        wr_bin <= wr_bin;
    end
end
assign wr_addr = wr_bin [ADDR_WIDTH - 1: 0];//to ram
wire [ADDR_WIDTH: 0]    wr_gray;
bi2gray u_bi2gray(wr_bin, wr_gray);
always @(posedge wr_clk, negedge wrst_n)    begin
    if (!wrst_n)
        wr_ptr <= 0;
    else begin
        wr_ptr <= wr_gray;//to synchronizer
    end
end

//full generation through gray code comp
assign full = (wr_ptr == {~(rdsync_ptr[ADDR_WIDTH : ADDR_WIDTH - 1]), rdsync_ptr[ADDR_WIDTH - 2: 0]});
endmodule
