`timescale 1ns/1ps
module top();
time t;
realtime rt;

initial begin 
#1.571;
t = $time;
rt = $realtime;
$display("t=%f,rt=%f", t,rt);
end 
endmodule
