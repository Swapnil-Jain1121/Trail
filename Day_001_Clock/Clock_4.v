//generate a clock of user provided frequency, duty cycle and jitter
//ex. - 100Mhz with 5% jitter - then range would be 95-105MHz
//$urandom_range(100,120) - generates random no. between 100 and 120

`timescale 1ns/1ps

module tb();
    reg clk;
    real freq, tp, duty;
    real jitter, jitter_factor, tp_jitter;
    
    
    always begin
        jitter_factor = $urandom_range(100-jitter,100+jitter)/100.0;
        tp_jitter     = tp * jitter_factor;
        clk           = 1; #(tp_jitter * (duty/100));
        clk           = 0; #(tp_jitter * ((100-duty)/100));
    end
    
    initial begin
        $value$plusargs("freq   = %f",freq);
        $value$plusargs("duty   = %f",duty);
        $value$plusargs("jitter = %f",jitter);
        //input frequency is in MHz, so equation to convert in ns is
        //1MHz = 10^6Hz = 10^-6 Sec = 10^-6 * 10^9 ns = 10^3 ns
        // 1MHz = 1000ns
        tp = 1000/freq;
        #400;
        $finish;
    end
endmodule
