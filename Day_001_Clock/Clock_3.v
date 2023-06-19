//generate a clock of user provided frequency and duty cycle

`timescale 1ns/1ps

module tb();
reg clk;
real freq, tp, duty;

always begin 
    clk = 1; #(tp * (duty/100));   
    clk = 0; #(tp * ((100-duty)/100));
end 

initial begin
    $value$plusargs("freq=%f",freq);
    $value$plusargs("duty=%f",duty);

    //input frequency is in MHz, so equation to convert in ns is 
    //1MHz = 10^6Hz = 10^-6 Sec = 10^-6 * 10^9 ns = 10^3 ns
    // 1MHz = 1000ns
    tp = 1000/freq;
    #200;
    $finish;
end
endmodule 