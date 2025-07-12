module EDAES #(parameter N=128, parameter Nr=10, parameter Nk=4)(
    input wire clk,
    input wire reset,
    output reg flag
);
    reg [N-1:0] state;
    wire [0:(N*(Nr+1))-1] fullKey;
    reg [5:0] counter;
    wire [N-1:0] next_state;
    wire [127:0] next_stateCounter0,
    afterShiftRowsCounter0,
    AfterRoundKeyDEC,
    next_state_DEC,
    afterShiftRowsDEC,
    afterMixColumnsDEC;
    wire [127:0] afterSubBytes, afterShiftRows,AfterMixColumns;
    wire [N-1:0] in = 128'h3243f6a8885a308d313198a2e0370734;
    wire [N-1:0] key = 128'h2b7e151628aed2a6abf7158809cf4f3c;

    keyExpansion #(Nk,Nr) KE(key, fullKey);
    subBytes SB(state, afterSubBytes);
    shiftRows SR(afterSubBytes, afterShiftRows);
    MixColumns MC(afterShiftRows, AfterMixColumns);
    addRoundKey ADK1(AfterMixColumns, next_state, fullKey[128*(counter) +:128]);
    
    addRoundKey ARK2(state,AfterRoundKeyDEC , fullKey[128*(Nr-(counter-11)) +:128]);
    inverseMixColumns IMC(AfterRoundKeyDEC, afterMixColumnsDEC);
    inverseShiftRows ISR(afterMixColumnsDEC, afterShiftRowsDEC);
    inverseSubBytes ISB(afterShiftRowsDEC, next_state_DEC);
    
    inverseShiftRows ISRC0(AfterRoundKeyDEC, afterShiftRowsCounter0);
    inverseSubBytes ISBC0(afterShiftRowsCounter0, next_stateCounter0);
    
    initial begin
    counter = -1;
    flag =0;
  end
    always @(posedge clk or posedge reset) begin
        if (reset) 
        begin
            state = in;
            counter = -1;
        end 
        else begin
          if(counter == 24)begin 
          end
        else begin
          counter = counter +1;
          if( counter == 0) state = in;
          else if (counter == 1) begin
                state = in ^ fullKey[0+:128];
          end 
          else if (counter > 1 && counter < 11) begin
                state = next_state;
            end
            else if (counter == 11) begin
              state =   afterShiftRows ^ fullKey[128*(counter-1) +:128];
            end
            else if (counter == 12) begin
              state = next_stateCounter0;
            end
          else if (counter > 12 && counter < 22) begin
                state = next_state_DEC;
            end
            else if (counter == 23) begin
                state = state ^ fullKey[0+:128];
                if(state == in) flag =1;
            end 
          end
      end
    end
endmodule
