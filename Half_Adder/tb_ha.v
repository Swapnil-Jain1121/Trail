`include"ha.v"
module tb_ha();
reg a,b;
wire sum, carry;

ha dut1(a,b,sum,carry);

initial begin 
#10;
a=0;b=0;
#10;
a=0;b=1;
#10;
a=1;b=0;
#10;
a=1;b=1;
end
endmodule