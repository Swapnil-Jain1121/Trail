`include "assign_2.v";
module tb_mux2_1();
    reg a,b,sel;
    wire out, out_bar;
    
    mux2_1 u0(.a(a),.b(b),.sel(sel),.out(out),.out_bar(out_bar));
    
    initial begin
        a       = 5;
        b       = 10;
        #5; sel = 1;
        #5; sel = 0;
        #20;
        $finish;
    end
endmodule
