module D_FF(D,
            Q,
            rst,
            clk);
    input D, clk, rst;
    output reg Q;
    
    always @(posedge clk) begin
        if (rst == 1) Q = 0;
        else Q  = D;
    end
endmodule
    
    
