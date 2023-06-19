`include "FA_Using_HA.v"
module tb_full_adder();
reg in1, in2, Cin;
wire Sum, Carry;

full_adder DUT (Sum, Carry, in1, in2, Cin);

initial begin 
#5;
in1 = 0; in2 = 0; Cin = 0;
#5;
in1 = 0; in2 = 0; Cin = 1;
#5;
in1 = 0; in2 = 1; Cin = 0;
#5;
in1 = 0; in2 = 1; Cin = 1;
#5;
in1 = 1; in2 = 0; Cin = 0;
#5;
in1 = 1; in2 = 0; Cin = 1;
#5;
in1 = 1; in2 = 1; Cin = 0;
#5;
in1 = 1; in2 = 1; Cin = 1;
#5;
end 

always @(*) begin 
$display("Sum = %0d, Carry = %0d", Sum, Carry); 
end
endmodule
