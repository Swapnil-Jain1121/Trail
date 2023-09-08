module mux2_1(a,
              b,
              sel,
              out,
              out_bar);
    input a,b,sel;
    output out, out_bar;
    
    assign out     = sel ? a : b;
    assign out_bar = ~out;
endmodule
    
    
    
