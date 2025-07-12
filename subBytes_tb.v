module subBytes_tb;
    reg [127:0] in;
    wire [127:0] out;
    reg [127:0] check;
    
    // Instantiate the module under test
    subBytes sb(in, out);
    
    initial begin
        // Monitor the input and output
        $monitor("input= %h, output= %h, check= %h", in, out,check);
        
        // Test case 1
        in = 128'h_193de3be_a0f4e22b_9ac68d2a_e9f84808;
        check = 128'h_D42711AE_E0BF98F1_B8B45DE5_1E415230;
        #20;
        
        // Test case 2
        in = 128'h_a49c7ff2_689f352b_6b5bea43_026a5049;
        check = 128'h_49DED289_45DB96F1_7F39871A_7702533B;
        #20;
        
        // Test case 3
        in = 128'h_aa8f5f03_61dde3ef_82d24ad2_6832469a;
        check = 128'h_AC73CF7B_EFC111DF_13B5D6B5_45235AB8;
        #20;
    end
    
    // Check output against expected results
    always @ (out) begin
        if (check == out) begin
            $display("Test passed for input %h", in);
        end else begin
            $display("Test failed for input %h. Expected %h but got %h", in, check, out);
        end
    end
endmodule