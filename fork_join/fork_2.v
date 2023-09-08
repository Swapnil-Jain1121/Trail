module tb();
    integer a,b,c;
    
    initial begin
        fork
        #5 a = 10;
        #5 b = 10;
        join
        #10; $finish;
        
        
    end
endmodule
