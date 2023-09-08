module tb();
    integer a,b;
    
    initial begin
        #0; a            = 10; b            = 20;
        #20; $display("a = %0d, b = %0d",a,b);
    end
    
    initial begin
        #5; a <= b; // value of b doesn't get assigned to a immidiately, it is stored in a temporary variable a_t, and gets updated in the last 1ns moment
    end
    
    initial begin
        #5; b <= a; // value of a doesn't get assigned to b immidiately
    end
endmodule
