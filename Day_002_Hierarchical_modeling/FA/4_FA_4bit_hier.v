//hierarchical modelling or structural style of implementation
`include "1_FA_1bit.v"
module FA_4bit_Using_1bit_FA(Sum, Cout, in1, in2, Cin);
input [3:0] in1, in2;
input Cin;
output [3:0]Sum;
output Cout;

wire n1,n2,n3;
FA_1bit DUT1(Sum[0], n1, in1[0], in2[0], Cin); //connection by position
FA_1bit DUT2(Sum[1], n2, in1[1], in2[1], n1);
FA_1bit DUT3(Sum[2], n3, in1[2], in2[2], n2);
FA_1bit DUT4(Sum[3], Cout, in1[3], in2[3], n3);

endmodule