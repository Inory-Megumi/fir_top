//Date		: 2022/3/29
//Author	: kehongbo
//Function	: dual-port ram
module ram #(
    parameter DEPTH = 16,
    parameter DATA_WIDTH = 4,
    parameter ADDR_WIDTH = 4
)
(
//write channel
    input   wr_clk,
    input   aclear,
    input   wr_en,
    input   [ADDR_WIDTH - 1:0]   wr_addr,
    input   [DATA_WIDTH - 1:0]   wr_data,
//read channel
    input   rd_clk,
    input   rd_en,
    input   [ADDR_WIDTH - 1:0]   rd_addr,
    output reg   [DATA_WIDTH - 1:0]   rd_data
);
//ram module
reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
//write
integer i;
always @(posedge wr_clk, negedge aclear) begin
    if(!aclear)
        begin
            for(i = 0; i < DEPTH; i = i + 1)
                mem[i] <= 1'b0;
        end
    else if (wr_en)
        mem[wr_addr] <= wr_data;
end
//read
always @(posedge rd_clk, negedge aclear) begin
    if(!aclear)
	rd_data <= 0;
    else if (rd_en)
        rd_data <= mem[rd_addr];
end
endmodule
