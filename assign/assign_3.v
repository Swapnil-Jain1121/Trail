module mux4_1(i0,
              i2,
              i3,
              s0,
              s1,
              out,
              out_bar);
    
    input i0,i1,i2,i3,s0,s1;
    output out, out_bar;
    
    //mux4_1
    assign out = s1 ? (s0 ? i3 : i2) : (s1 ? i1 : i0);
    // s1 = 1, s0 = 1 = > out = i4
    
    //mux8_1
    assign out = s2 ? (s1 ? (s0 ? i7 : i6) : (s1 ? i5 : i4)) : (s1 ? (s0 ? i3 : i2) : (s1 ? i1 : i0));
    // s2 = 1, s1 = 1, s0 = 1 = > out = i7
    // s2 = 0, s1 = 0, s0 = 0 = > out = i0
    
    
    
    
    assign out_bar = ~out;
endmodule
    
    s1  s0    out
    0   0   - i0;
    0   1   - i1;
    1   0   - i2;
    1   1   - i3;
