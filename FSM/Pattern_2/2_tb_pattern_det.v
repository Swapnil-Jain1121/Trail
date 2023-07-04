// `include "2_pattern_det_moore.v"
`include "2_pattern_det_mealy.v"

module tb();
    
    reg clk, rst, d_in, valid_in;
    wire pattern_detected;
    integer seed;
    integer count;
    pattern_det dut(clk, rst, d_in, valid_in, pattern_detected);
    
    always begin
        #5 clk = 0;
        #5 clk = 1;
    end
    
    initial begin
        seed  = 37587;
        count = 0;
        rst   = 1;
        #10;
        rst = 0;
        // applying stimulus
        
        repeat(540) begin
            @(posedge clk);
            valid_in = 1'b1;
            d_in     = $random(seed);
        end
        
        @(posedge clk);
        valid_in              = 1'b0;
        d_in                  = 0;
        $display("total count = %0d", count);
        #50;
        $finish;
    end
    
    always @(posedge pattern_detected) begin
        count = count + 1;
    end
    
endmodule
