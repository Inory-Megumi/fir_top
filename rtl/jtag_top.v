//Date		: 2022/4/9
//Author	: kehongbo
//Function	: tap state machine
module jtag_top#(parameter Wordlen = 4)
(
    input tck,
    input por,//power on reset
    input tms,
    input tdi,
    input desync,//desync
    output tdo,
    output reg wr_en,
    output [Wordlen - 1 : 0] wr_data
);
//parameter
parameter TEST_LOGIC_RESET = 4'hf;
parameter RUN_TEST_IDLE = 4'hc;
parameter SELECT_DR_SCAN = 4'h7;
parameter CAPTURE_DR = 4'h6;
parameter SHIFT_DR = 4'h2;
parameter EXIT1_DR = 4'h1;
parameter PAUSE_DR = 4'h3;
parameter EXIT2_DR = 4'h0;
parameter UPDATE_DR = 4'h5;
parameter SELECT_IR_SCAN = 4'h4;
parameter CAPTURE_IR = 4'he;
parameter SHIFT_IR = 4'ha;
parameter EXIT1_IR = 4'h9;
parameter PAUSE_IR = 4'hb;
parameter EXIT2_IR = 4'h8;
parameter UPDATE_IR = 4'hd;
//instruction mode no idcode
parameter Bypass = 2'b00;
parameter Intest = 2'b01;
parameter Config = 2'b10;

//config chain
parameter SyncWord = 4'b1111;
//tap
wire [3:0] state;
tap_ctrl tap(tck,por,tms,state);
/*          instruction chain           */
reg [1:0] IR;
reg [1:0] SIR;
//shift
always @(posedge tck, negedge por) begin
    if(!por)
        SIR <= Bypass;
    else if(state == TEST_LOGIC_RESET)
        SIR <= Bypass;
    else if(state == CAPTURE_IR)//? set parallel IR
        SIR <= Bypass;
    else if(state == SHIFT_IR)
        SIR <= {tdi, SIR[1]};
end
//update IR
always @(negedge tck, negedge por) begin
    if(!por)
        IR <= Bypass;
    else if(state == TEST_LOGIC_RESET)
        IR <= Bypass;
    else if(state == UPDATE_IR)
        IR <= SIR;
end
    
/*          Bypass          */
reg BypReg;
always @(posedge tck, negedge por) begin
    if(!por)
        BypReg <= 1'b0;
    else if(state == CAPTURE_DR && IR == Bypass)
        BypReg <= 1'b0;
    else if(state == SHIFT_DR && IR == Bypass)
        BypReg <= tdi;
end
/*          Config          */
reg [Wordlen - 1:0] SCF;
reg sync;
reg [1:0] SftCnt;
//shift
always @(posedge tck, negedge por) begin
    if(!por)
        SCF <= 4'b0;
    else if(state == TEST_LOGIC_RESET)
        SCF <= 4'b0;
    else if(state == SHIFT_DR && IR == Config)
        SCF <= {tdi,SCF[Wordlen - 1 : 1]};
end
//sync
always @(posedge tck, negedge por)
begin
    if(!por)
        sync <= 1'b0;
    else if(state == TEST_LOGIC_RESET)
        sync <= 1'b0;
    else if(SCF == SyncWord)
        sync <= 1'b1;//?????????
    else if (desync == 1'b1)
        sync <= 1'b0;
end
//cnt
always @(posedge tck, negedge por) begin
    if(!por)
        SftCnt <= 0;
    else if(state == TEST_LOGIC_RESET)
        SftCnt <= 0;
    else if(~sync)
        SftCnt <= 0;
    else if(state == SHIFT_DR && IR == Config && sync)
        SftCnt <= SftCnt + 1;
end
//enable writing to fifo
always @(*) begin
    if(state == SHIFT_DR && IR == Config && sync && SftCnt == 3)
        wr_en = 1'b1;
    else
        wr_en = 1'b0;
end
assign wr_data = SCF;

/*          Output muxplexer            */
reg tdo_o;
reg tdo_t;//enable
always @(negedge tck, negedge por)   begin //output when clock meets the negative edge
    if(!por)
	tdo_o <= 1'b0;
    else if(state == SHIFT_IR)
        tdo_o <= SIR[0];
    else if(state == SHIFT_DR)
        case(IR)
            Bypass:tdo_o <= BypReg;
            Config:tdo_o <= SCF[0];//lsb first out
            default:tdo_o <= 1'b0;
endcase
end
always @(negedge tck, negedge por) begin
    if(!por)
        tdo_t <= 1'b0;
    else if(state == SHIFT_IR)
        tdo_t <= 1'b0;
    else if(state == SHIFT_DR)
        tdo_t <= 1'b0;
    else
        tdo_t <= 1'b1;
end
assign tdo = tdo_t ? 1'bz : tdo_o;
endmodule

