module FA_1bit(Sum,
               Cout,
               in1,
               in2,
               Cin);
    input in1, in2, Cin;
    output Sum, Cout;
    
    assign {Cout, Sum} = in1 + in2 + Cin;
    //                     1    1   1 = > 3 = > 2'b11 = > Carry = 1 , Sum = 1
    
endmodule
