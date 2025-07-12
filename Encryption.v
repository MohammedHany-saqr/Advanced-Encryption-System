module Encryption #(parameter N=128, parameter Nr=10, parameter Nk=4)(
    input wire clk,
    input wire reset
);
    reg [N-1:0] state;
    wire [0:(N*(Nr+1))-1] fullKey;
    reg [4:0] counter;
    wire [N-1:0] next_state;
    wire [127:0] afterSubBytes, afterShiftRows,AfterMixColumns;
    wire [N-1:0] in = 128'h3243f6a8885a308d313198a2e0370734;
    wire [N-1:0] key = 128'h2b7e151628aed2a6abf7158809cf4f3c;

    keyExpansion #(Nk,Nr) ke(key, fullKey);
    subBytes b1(state, afterSubBytes);
    shiftRows r1(afterSubBytes, afterShiftRows);
    MixColumns m1(afterShiftRows, AfterMixColumns);
    addRoundKey ke2(AfterMixColumns, next_state, fullKey[128*(counter) +:128]);
    initial counter = -1;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state = in;
            counter = -1;
        end else begin
          if(counter == 24)begin
          end
        else begin
          counter = counter + 1;
          if( counter == 0) state = in;
          else if (counter == 1) begin
                state = in ^ fullKey[0+:128];
            end else if (counter > 1 && counter < 11) begin
                state = next_state;
            end
            else if (counter == 11) begin
              state =   afterShiftRows ^ fullKey[128*(counter-1) +:128];
            end
          end
        end
    end
endmodule
/*
vsim work.Encryption
add wave -position insertpoint sim:/Encryption/*
force -freeze sim:/Encryption/clk 1 0, 0 {50 ps} -r 100
run 3000
*/