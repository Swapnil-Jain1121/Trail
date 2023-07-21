module D_FF(D,
            rst,
            clk,
            Q,
            Q_bar);
    input D, clk, rst;
    output Q, Q_bar;
    
    wire n1,n2,n3;
    
    nand g1(n1, D,clk);
    nand g2(n2, D,D);
    nand g3(n3, n2,clk);
    nand g4(Q, n1,Q_bar);
    nand g5(Q_bar, Q,n3);
    
endmodule
    
    
