module FA_4bit(Sum,
               Cout,
               in1,
               in2,
               Cin);
    input [3:0] in1, in2;
    input Cin;
    output [3:0]Sum;
    output Cout;
    
    assign {Cout, Sum} = in1 + in2 + Cin;
    //                     10    9   1 = > 20 = > 10100 = > Cout = 1 , Sum = 0100
    //                     7     3   0 = > 10 = > 1010 = > Cout = 0 , Sum = 1010
    
    
endmodule
