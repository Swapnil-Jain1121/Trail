module tb();
    integer a,b;
    
    initial begin
        #0; a            = 10; b            = 20;
        #20; $display("a = %0d, b = %0d",a,b);
    end
    
    initial begin
        #5; a = b; // value of b gets assigned to a immidiately
    end
    
    initial begin
        #5; b = a; // value of a gets assigned to b immidiately
    end
endmodule
