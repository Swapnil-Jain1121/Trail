module interrupt(int0,
                 int1,
                 int2,
                 irq);
    input irq;
    output integer int0,int1,int2;
    
    always@(irq) begin
        int0 = 0;
        int1 = 0;
        int2 = 0;
        case (irq) begin
        3'b100: int2 = 1;
        3'b110: int2 = 1;
        3'b101: int2 = 1;
        3'b111: int2 = 1;
        3'b011: int1 = 1;
        3'b010: int1 = 1;
        3'b001: int0 = 1;
        default : $display("no interrupt");
        endcase
        
    end
    
endmodule
