// `include "4_FA_4bit_hier.v"
`include "4_FA_nbit_genvar.v"
module tb_FA_4bit();
reg [3:0] in1, in2;
reg Cin;
wire [3:0]Sum;
wire Cout;

FA_nbit_Using_1bit_FA DUT(Sum, Cout, in1, in2, Cin);

initial begin 
repeat(10) begin
#1; 
{in1,in2,Cin} = $random; // $random generates 32 bit no. 
//Cin will get 0th bit
//in2 will get [4:1]
//in1 will get [8:5]
end
end 

initial begin
    $monitor("time = %0t : in1 = %0d, in2 = %0d, Cin = %b, Sum = %0d, Cout = %b", $time, in1, in2, Cin, Sum, Cout);
end

endmodule