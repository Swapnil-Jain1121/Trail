`include "Half_Adder.v"
module tb_half_adder();
reg A,B;
wire Sum, Carry;

half_adder DUT (Sum, Carry, A,B);

initial begin 
#5;
A = 0; B = 0;
#5;
A = 0; B = 1;
#5;
A = 1; B = 0;
#5;
A = 1; B = 1;
#5;
end 

always @(*) begin 
$display("Sum = %0d, Carry = %0d", Sum, Carry);
#30;
$finish; 
end
endmodule
