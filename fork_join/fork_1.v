module tb();
    integer a,b,c;
    
    initial begin
        fork
        begin
        #5 a = 10;
        #5 b = 10;
    end
    
    #5 c = 10;
    join
    #10; $finish;
    
    
    end
endmodule
