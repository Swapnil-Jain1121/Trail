module tb();
    reg [5:0] a,b,c,delay;
    
    always @(a) begin
        $display("%0t : Entry", $time);
        #10 b = a;
        #5 c  = b;
        
    end
    initial begin
        repeat(30) begin
            delay = $urandom_range(5,10);
            #delay;
            a = $random(0,100)%100; //random number between 0 and 100
        end
        #100;
        $finish;
    end
endmodule
