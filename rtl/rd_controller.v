//Date		: 2022/3/29
//Author	: kehongbo
//Function	: rdite domain controller
module rd_controller
#(
    parameter ADDR_WIDTH = 4
)
(
    input   rd_clk,
    input   rdst_n,
    input   rd_en,
    input  [ADDR_WIDTH : 0] wrsync_ptr,//wr_ptr after synchronization
    output reg [ADDR_WIDTH : 0] rd_ptr,
    output  [ADDR_WIDTH - 1 : 0] rd_addr,
    output  empty
);
reg [ADDR_WIDTH : 0] rd_bin;//attention! bits + 1 
always @(posedge rd_clk, negedge rdst_n)    begin
    if (!rdst_n)
        rd_bin <= 0;
    else if (rd_en && !empty) begin
        rd_bin <= rd_bin + 1;
    end
    else begin
        rd_bin <= rd_bin;
    end
end
assign rd_addr = rd_bin [ADDR_WIDTH - 1: 0];//to ram
wire [ADDR_WIDTH : 0]    rd_gray;
bi2gray u_bi2gray(rd_bin, rd_gray);
always @(posedge rd_clk, negedge rdst_n)    begin
    if (!rdst_n)
        rd_ptr <= 0;
    else begin
        rd_ptr <= rd_gray;//to synchronizer
    end
end

//full generation through gray code comp
assign empty = (rd_ptr == wrsync_ptr);
endmodule
