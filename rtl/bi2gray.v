module bi2gray #(parameter width = 4 + 1) (
    input [width-1:0] bin,
    output [width-1:0] gray
);
    assign gray = (bin >> 1) ^ bin;
endmodule
