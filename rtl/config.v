//Date		: 2022/3/29
//Author	: kehongbo
//Function	: fifo_top
module config_top
(
    input clk,
    input rstn,
    input [3:0] in,
    input empty,
    output reg [3:0] w0,
    output reg [3:0] w1,
    output reg fir_open
);
parameter AnalyzeInstruction = 1'b0;
parameter ReceiveData = 1'b1;
//opcode
parameter null = 2'b00;
parameter write = 2'b01;
parameter boot = 2'b10;
parameter shutdown = 2'b11;

reg state;
reg next_state;
wire w_state;//decide which w to write in
//state register
always @(posedge clk, negedge rstn)
begin
    if(!rstn)
        state <= AnalyzeInstruction;
    else
        state <= next_state;
end

//next_state logic
wire [1:0] opcode;
assign opcode = in [3:2];
/*
00:null
01:write data next cp
10:open fir
11:close fir 
*/
always @(*) begin
    case(state)
        AnalyzeInstruction:
            if(~empty&&(opcode == 2'b01))
                next_state = ReceiveData;
            else 
                next_state = AnalyzeInstruction;
        ReceiveData:
            next_state = AnalyzeInstruction;
    endcase
end
//output logic
//open fir
always @(posedge clk, negedge rstn)
begin
    if(!rstn)
        fir_open <= 1'b0;//fir close
    else
    begin
        if(state == AnalyzeInstruction) begin
        if(opcode == 2'b11 || opcode == 2'b01)
            fir_open <= 1'b0;
        else if(opcode == 2'b10)
            fir_open <= 1'b1;
        else
            fir_open <= fir_open;
    end
        else//Receive data shutdown the fir
            fir_open <= 1'b0;
    end
end
//w register
reg [1:0] w_select;//此处可以精简
always @(posedge clk, negedge rstn) begin//寄存指令中的片选信号
    if(!rstn)
        w_select <= 2'b00;
    else
        w_select <= in [1:0];//片选信号打一拍
end
assign w_state = w_select[1];
//write the w register
always @(posedge clk, negedge rstn)
begin
    if(!rstn) begin
        w0 <= 4'b0;
        w1 <= 4'b0;
    end
    else
    begin
        if(state == ReceiveData && !w_state)//这里可以仔细看看仿真
            w0 <= in;
        else if(state == ReceiveData && w_state)
            w1 <= in;
    end         
end
endmodule


