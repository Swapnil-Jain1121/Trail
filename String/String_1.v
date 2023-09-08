module tb();
reg [8*13:1] string_val;

initial begin 
string_val = "Hello Verilog";
$display("string_val = %0d", string_val);
end


endmodule