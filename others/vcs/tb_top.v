`timescale 1ns/1ps
module tb_top;
parameter T_w = 20;
parameter T_r = 10; 
reg w_clk, w_rstn, r_clk, r_rstn, tms, tdi;
wire tdo,fir_open;
wire [3:0] w0;
wire [3:0] w1;
fir_top my_fir
(
    .w_clk(w_clk),
    .w_rstn(w_rstn),
    .tms(tms),
    .desync(1'b0),
    .tdi(tdi),
    .tdo(tdo),
    .r_clk(r_clk),
    .r_rstn(r_rstn),
    .w0(w0),
    .w1(w1),
    .fir_open(fir_open)
);
initial 
begin
$sdf_annotate("fir_top.sdf",my_fir);
end

initial w_clk = 0;
always#(T_w) w_clk = ~w_clk;

initial begin
r_clk = 1;
#3; r_clk =0;
end
always#(T_r) r_clk = ~r_clk;

//rst
initial begin
    w_rstn = 1;
#5; w_rstn = 0;
#5; w_rstn = 1;
end

initial begin
    r_rstn = 1;
#10; r_rstn = 0;
#10; r_rstn = 1;
end


reg [18:0] tms_buffer;
reg [66:0] tdi_buffer;

parameter instruction_Set = 48'b100000110001001011010110111011101111101011101101;

always@(negedge w_clk, negedge w_rstn) begin
if(!w_rstn)    begin
    tms <= 1'b1;
    tdi <=  1'b0;
    tms_buffer <= 19'b0110001011010000000;
    tdi_buffer <= {19'b0000001000000001111,instruction_Set};//tdi数据要比tms延后一周期
end
else
begin
    tms <= tms_buffer[18];
    tdi <= tdi_buffer[66];
    tms_buffer <= tms_buffer << 1;
    tdi_buffer <= tdi_buffer << 1;
end
end
endmodule
