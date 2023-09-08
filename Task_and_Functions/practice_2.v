module practice();
    
    integer intA1[5:0];
    integer intA2[5:0];
    integer intA3[5:0];
    
    integer i;
    
    initial
    begin
        intA3[0] = 0;
        intA3[1] = 0;
        intA3[2] = 0;
        intA3[3] = 0;
        intA3[4] = 0;
        intA3[5] = 0;
        
        for(i = 0; i <6; i = i +1) begin
            intA1[i]             = $urandom_range(0,5);
            intA2[i]             = $urandom_range(0,5);
            intA3[i]             = sum(intA1[i], intA2[i]);
            $display("intA1[%0d] = %0d, intA2[%0d] = %0d, intA3[%0d] = %0d", i, intA1[i],i, intA2[i], i, intA3[i]);
            
        end
    end
    
    
    function integer sum(input integer a, input integer b);
        begin
            sum = a+b;
        end
    endfunction
    
    function integer sub(input integer a, input integer b);
        begin
            sub = a-b;
        end
    endfunction
endmodule
