//hierarchical modelling or structural style of implementation
`include "1_FA_1bit.v"
module FA_nbit_Using_1bit_FA(Sum, Cout, in1, in2, Cin);
parameter WIDTH = 4;
input [WIDTH-1:0] in1, in2;
input Cin;
output [WIDTH-1:0]Sum;
output Cout;

wire [WIDTH:0] Carry_in; // size of this vector shall be one greater than the required bit adder
assign Carry_in[0] = Cin;
assign Cout = Carry_in[WIDTH];

genvar i; //dont declare as an integer
//genvar : generation variable 
//code generation variable


for(i=0; i < WIDTH; i = i+1) begin

FA_1bit DUT(Sum[i], Carry_in[i+1], in1[i], in2[i], Carry_in[i]); 

// FA_1bit DUT1(Sum[0], Carry_in[1], in1[0], in2[0], Carry_in[0]); 
// FA_1bit DUT2(Sum[1], Carry_in[2], in1[1], in2[1], Carry_in[1]);
// FA_1bit DUT3(Sum[2], Carry_in[3], in1[2], in2[2], Carry_in[2]);
// FA_1bit DUT4(Sum[3], Carry_in[4], in1[3], in2[3], Carry_in[3]);

end
endmodule