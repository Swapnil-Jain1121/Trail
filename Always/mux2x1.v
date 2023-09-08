module mux2x1(i0,
              i1,
              s0,
              out);
    input i0,i1,s0;
    output out;
    
    always @(i0,i1,s0) begin
        if (s0) out = i1;
        else out    = i0;
    end
endmodule
