// `include "1_mux8x1_if_elseif.v"
`include "1_mux8x1_case.v"

module tb_mux8x1();
    reg [7:0]in;
    reg [2:0] sel;
    wire out;
    
    mux8x1 u0(.in(in),.sel(sel), .out(out));
    
    initial begin
        
        $monitor("sel = %b, in = %b, out = %b", sel, in, out);
        
        // Test case 1
        in  = 8'b01010101;
        sel = 3'b000;
        #10;
        
        // Test case 2
        in  = 8'b10101010;
        sel = 3'b111;
        #10;
        
        // Test case 3
        in  = 8'b11110000;
        sel = 3'b010;
        #10;
        
        // Add more test cases here
        
        $finish;
        
        
    end
    
    initial begin
        $display("out = %0d", out);
    end
endmodule
    
    
    
