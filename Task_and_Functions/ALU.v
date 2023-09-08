module ALU();
    
    parameter ADD = 4'b0000;
    parameter SUB = 4'b0001;
    parameter MUL = 4'b0010;
    parameter DIV = 4'b0011;
    reg[7:0] in1;
    reg[7:0] in2;
    reg[7:0] Addition;
    reg[7:0] Substraction;
    reg[7:0] Multiplication;
    reg[7:0] Division;
    
    
    
    initial begin
        in1 = $urandom_range(10,20);
        in2 = $urandom_range(5,10);
        
        Addition                            = alu_func(in1, in2,ADD);
        $display("Addition of %d, and %d is = %0d", in1, in2, Addition);
        
        Substraction                            = alu_func(in1, in2,SUB);
        $display("Substraction of %d, and %d is = %0d", in1, in2, Substraction);
        
        Multiplication                            = alu_func(in1, in2,MUL);
        $display("Multiplication of %d, and %d is = %0d", in1, in2, Multiplication);
        
        Division                            = alu_func(in1, in2,DIV);
        $display("Division of %d, and %d is = %0d", in1, in2, Division);
        
    end
    
    function reg [31:0] alu_func(input [7:0] in1, input [7:0] in2, input [3:0] operation);
        begin
            case(operation)
                ADD: begin
                    alu_func = in1 + in2;
                end
                
                MUL: begin
                    alu_func = in1 * in2;
                end
                
                DIV: begin
                    alu_func = in1 / in2;
                end
                
                SUB: begin
                    alu_func = in1 - in2;
                end
            endcase
        end
        
    endfunction
    
endmodule
    
