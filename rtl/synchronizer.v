//Date		: 2022/3/29
//Author	: kehongbo
//Function	: synchronizer
module synchronizer#(parameter WIDTH = 5)   
(   
    input   cdc_clk,
    input   cdc_rstn,
    input   [WIDTH - 1: 0]  input_signal,
    output  reg  [WIDTH - 1: 0]  output_signal  
);
reg [WIDTH - 1: 0]  ff_temp;

always @(posedge cdc_clk, negedge cdc_rstn) begin
    if (!cdc_rstn)  begin
        ff_temp <= 0;
        output_signal <=0;
    end
    else    begin
        ff_temp <= input_signal;
        output_signal <= ff_temp;
    end
end
endmodule
