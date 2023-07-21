// `include"D_FF_Behavioral.v";
`include"D_FF_Gate_Level.v"

module tb();
    reg D, clk, rst;
    wire Q, Q_bar ;
    
    always #5 clk = ~clk;
    D_FF u0(.D(D), .clk(clk), .Q(Q), .Q_bar(Q_bar));
    
    //default connection
    // D_FF u0(.*);
    
    initial begin
        clk = 0;
        rst = 1;
        #10;
        rst = 0;
        repeat(5) begin
            D = 1; #6;
            D = 0; #6;
        end
        #200;
        $finish;
    end
    
    initial begin
        $monitor("time = %0t,D = %0d, Q = %0d, Q_bar = %0d",$time, D,Q,Q_bar);
    end
    
endmodule
    
    
