//caseZ for interrupt handling
//priority encoder irq[2]>irq[1]>irq[0]
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
        casez(irq) begin
        3'b1??: int2 = 1;
        3'b?1?: int1 = 1;
        3'b??1: int0 = 1;
        default : $display("no interrupt");
        endcase
        
    end
    
endmodule
