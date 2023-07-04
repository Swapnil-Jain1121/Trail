// `include "pattern_det_moore.v"
`include "pattern_det_mealy.v"

module tb();
    
    reg clk, rst, d_in, valid_in;
    wire pattern_detected;
    
    integer count;
    integer seed;
    
    
    pattern_det dut(clk,rst, d_in, valid_in, pattern_detected);
    
    //clock generation
    always begin
        #5 clk = 0;
        #5 clk = 1;
    end
    
    initial begin
        count = 0;
        seed  = 361786;
        
        rst = 1;
        #20;
        rst = 0;
        //apply stimulus
        repeat(540) begin // lets say each minute bike or car is passing, so in 9 hours i.e. 540 minutes
            @(posedge clk) ;
            d_in     = $random(seed); //either 0 or 1
            valid_in = 1'b1;
        end
        
        @(posedge clk);
        valid_in                                      = 1'b0;
        d_in                                          = 1'b0;
        $display("Total Count of pattern detected are = %0d", count);
        #50;
        $finish;
        
        
    end
    always @(posedge pattern_detected) begin
        count = count + 1;
    end
endmodule
