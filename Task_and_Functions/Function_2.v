//addition of array
module tb();
    integer array_1 [4:0];
    integer array_2 [4:0];
    integer array_3 [4:0];
    integer i;
    
    
    initial begin
        array_1[0] = 1;
        array_1[1] = 2;
        array_1[2] = 3;
        array_1[3] = 4;
        array_1[4] = 5;
        
        array_2[0] = 1;
        array_2[1] = 2;
        array_2[2] = 3;
        array_2[3] = 4;
        array_2[4] = 5;
        
        
        
        for(i = 0; i<5; i = i+1) begin
            array_3[i]             = add(array_1[i], array_2[i]);
            $display("array_3[%0d] = %0d",i,array_3[i]);
        end
    end
    
    function integer add(input integer a, input integer b);
        begin
            add = a + b;
        end
    endfunction
    
endmodule
