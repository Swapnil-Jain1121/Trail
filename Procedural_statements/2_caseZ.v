module tb();
    reg [1:0]a;
    initial begin
        a = 2'b1x;
        casex(a)
            2'b00: begin
                $display("E1");
            end
            
            2'b10: begin
                $display("E2");
            end
            
            2'b11: begin
                $display("E3");
            end
            
            2'b1x: begin
                $display("E4");
            end
            
            2'b1z: begin
                $display("E5");
            end
            
        endcase
        
    end
endmodule
