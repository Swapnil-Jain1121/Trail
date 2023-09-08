module tb();
    integer b,c; //integer means reg [31:0]
    
    wire [31:0] a;
    assign #3 a = b&c;
    
    initial begin
        #0;
        b = 0;
        c = 0;
        #10;
        b = 115;
        c = 120;
        #10;
        $finish;
    end
    
endmodule
