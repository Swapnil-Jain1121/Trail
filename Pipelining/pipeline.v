module pipeling(clk,
                rst,
                d,
                j,
                k,
                l,
                q);
    input clk, rst, d,j,k,l;
    output q;
    
    
    //combination using blocking
    always @(*) begin
        d_t  = comb_1(d,j,k,l); //comb_n - function
        q1_t = comb_2(q1);
        q2_t = comb_2(q2);
        q    = comb_2(q3);
    end
    
    // // also can be implemented using assign statement
    // assign d_t   = comb_1(d,j,k,l); //comb_n - function
    // assign  q1_t = comb_2(q1);
    // assign  q2_t = comb_2(q2);
    // assign   q   = comb_2(q3);
    
    //sequential using non-blocking
    always @(posedge clk) begin
        q1 <= d_t; //1st stage FF
        q2 <= q1_t; //2nd stage FF
        q3 <= q2_t; //3rd stage FF
        
    end
endmodule
