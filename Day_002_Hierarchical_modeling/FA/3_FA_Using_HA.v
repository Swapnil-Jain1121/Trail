module full_adder(Sum, Carry, in1, in2, Cin);
input in1, in2, Cin;
output Sum, Carry;

wire I1, I2, I3;

half_adder DUT1(I1, I2, in1, in2);
half_adder DUT2(Sum, I3, I1, Cin);
assign Carry = I3 | I2;

endmodule