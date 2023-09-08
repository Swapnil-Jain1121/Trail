module tb();
    reg clk;
    
    initial begin
        clk            = 0;
        forever #5 clk = ~clk;
    end
    
    always @(posedge clk) begin
        $display("%t: ENTRY :: 1", $time);
    end
    
    always @(posedge clk) begin
        #15;
        $display("\t%t: ENTRY :: 2", $time);
    end
    initial begin
        #100;
        $finish;
    end
endmodule
