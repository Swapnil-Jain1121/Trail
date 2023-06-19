//generate a clock of 100MHz
//100MHz => 10ns

module tb();
reg clk;

always begin 
    clk = 1; #5;
    clk = 0; #5;
end 

initial begin
    #200;
    $finish;
end
endmodule 