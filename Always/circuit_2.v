module sample(a,
              b,
              res,
              clk,
              Y,
              );
    input a,b,rst,clk;
    output reg Y;
    wire n1,n2;
    
    assign n2               = n1&b;
    // always @(n1 or b) n2 = n1&b;
    
    
    always @(posedge clk) begin
        if (rst == 1) begin
            Y = 0;
        end
        else begin
            
        end
    end
endmodule
