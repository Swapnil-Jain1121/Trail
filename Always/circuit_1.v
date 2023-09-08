module sample(a,
              b,
              c,
              res,
              clk,
              Y,
              W);
    input a,b,c,rst,clk;
    output reg Y,W;
    
    always @(posedge clk) begin
        if (rst == 1) begin
            Y = 0;
            W = 0;
        end
        else begin
            Y = a&b;
            W = ~c;
        end
    end
endmodule
