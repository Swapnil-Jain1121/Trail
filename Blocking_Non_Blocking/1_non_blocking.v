module tb();
    
    reg clk;
    reg d,Q1,Q2,Q3;
    
    initial begin
        clk            = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        d = 0; #12;
        d = 1; #10;
        d = 0; #13;
        d = 1; #12;
        d = 0; #10;
        $finish;
    end
    
    always @(posedge clk) begin
        Q1 <= d; //Q1 in this assignment will not get updated immidiately
        Q2 <= Q1; //will use old value of Q1, not the updated one
        Q3 <= Q2; //will use old value of Q2, not the updated one
    end
endmodule
