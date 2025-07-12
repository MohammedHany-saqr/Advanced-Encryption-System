module Decryt #(parameter N=128, parameter Nr=10, parameter Nk=4)(
    input wire clk,
    input wire reset
);
    reg [N-1:0] state;
    wire [0:(N*(Nr+1))-1] fullKey;
    reg [4:0] counter;
    wire [N-1:0] next_state;
    wire [127:0] afterMixColumns, afterShiftRows,AfterRoundKey,afterShiftRowsCounter0,next_stateCounter0;
    wire [N-1:0] in  = 128'h3925841d02dc09fbdc118597196a0b32;
    wire [N-1:0] key = 128'h2b7e151628aed2a6abf7158809cf4f3c;

    keyExpansion #(Nk,Nr) ke(key, fullKey);
    addRoundKey ke2(state,AfterRoundKey , fullKey[128*(Nr-counter) +:128]);
    inverseMixColumns imc(AfterRoundKey, afterMixColumns);
    inverseShiftRows r1(afterMixColumns, afterShiftRows);
    inverseSubBytes b1(afterShiftRows, next_state);
    
    inverseShiftRows r2(AfterRoundKey, afterShiftRowsCounter0);
    inverseSubBytes b2(afterShiftRowsCounter0, next_stateCounter0);
      
    initial counter = -1;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state = in;
            counter = -1;
        end else begin
          counter = counter +1;
          if( counter == 0) state = in;
          else if (counter == 11) begin
                state = state ^ fullKey[0+:128];
            end else if (counter > 1 && counter < 11) begin
                state = next_state;
            end
            else if (counter == 1) begin
              state = next_stateCounter0;
            end
        end
    end
endmodule
