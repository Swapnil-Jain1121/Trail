module tb();
    integer intA[9:0];
    integer i;
    
    
    initial begin
        for (i = 0; i<10; i = i+1) begin
            intA[i] = $urandom_range(40,49);
        end
        
        for (i = 0; i<10; i = i+1) begin
            $display("intA[%0d] = %0d", i, intA[i]);
        end
    end
endmodule
