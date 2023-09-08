`include"primitive_1.v"
module tb();
    reg in1,in0,sel;
    wire y;
    mux2x1 u0(y,in1,in0,sel);
    
    initial begin
        #10;
        in1 = 0;
        in0 = 0;
        sel = 0;
        
        #10;
        in1 = 0;
        in0 = 1;
        sel = 0;
        
        #10;
        in1 = 0;
        in0 = 0;
        sel = 1;
        
        #10;
        in1 = 1;
        in0 = 0;
        sel = 1;
        
        #10;
        $finish;
    end
    
    initial begin
        $monitor("in1 = %0d,in0 = %0d,sel = %0d, y = %0d", in1,in0,sel,y);
    end
endmodule
