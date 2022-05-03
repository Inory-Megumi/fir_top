//Date		: 2022/4/9
//Author	: kehongbo
//Function	: tap state machine
module tap_ctrl
(
    input tck,
    input por,//Power on Reset
    input tms,
    output reg [3:0] state
);
//state encoding
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
//state register
reg [3:0] next_state;
always @(posedge tck, negedge por)   begin
    if(!por)
        state <= TEST_LOGIC_RESET;
    else
    state <= next_state;
end
//next state logic
always @(*)
  case(state)
    TEST_LOGIC_RESET: if(tms)
                        next_state =TEST_LOGIC_RESET;
                      else
                        next_state =RUN_TEST_IDLE;
    RUN_TEST_IDLE: if( tms )
                     next_state =SELECT_DR_SCAN;
                   else
                     next_state =RUN_TEST_IDLE;
    SELECT_DR_SCAN: if(tms)
                      next_state =SELECT_IR_SCAN;
                    else
                      next_state =CAPTURE_DR;
    CAPTURE_DR: if(tms)
                  next_state =EXIT1_DR;
                else
                  next_state =SHIFT_DR;
    SHIFT_DR: if(tms)
                next_state =EXIT1_DR;
              else
                next_state =SHIFT_DR;
    EXIT1_DR: if(tms)
                next_state =UPDATE_DR;
              else
                next_state =PAUSE_DR;
    PAUSE_DR: if(tms)
                next_state =EXIT2_DR;
              else
                next_state =PAUSE_DR;
    EXIT2_DR: if(tms)
                next_state =UPDATE_DR;
              else
                next_state =SHIFT_DR;
    UPDATE_DR: if(tms)
                next_state =SELECT_DR_SCAN;
              else
                next_state =RUN_TEST_IDLE;
    SELECT_IR_SCAN:if(tms)
                     next_state =TEST_LOGIC_RESET;
                   else
                     next_state =CAPTURE_IR;
    CAPTURE_IR: if(tms)
                  next_state =EXIT1_IR;
                else
                  next_state =SHIFT_IR;
    SHIFT_IR: if(tms)
                next_state =EXIT1_IR;
              else
                next_state =SHIFT_IR;
    EXIT1_IR: if(tms)
                next_state =UPDATE_IR;
              else
                next_state =PAUSE_IR;
    PAUSE_IR: if(tms)
                next_state =EXIT2_IR;
              else
                next_state =PAUSE_IR;
    EXIT2_IR: if(tms)
                next_state =UPDATE_IR;
              else
                next_state =SHIFT_IR;
    UPDATE_IR: if(tms)
                next_state =SELECT_DR_SCAN;
              else
                next_state =RUN_TEST_IDLE;
  endcase
endmodule