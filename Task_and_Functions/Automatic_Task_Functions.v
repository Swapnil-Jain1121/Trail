//recursive function task

module top();
    
    integer a;
    integer factorial;
    
    
    initial begin
        a         = 3;
        factorial = fact(a);
        $display("Factorial of %0d is %0d", a, factorial);
        
    end
    
    // function automatic integer fact(input integer a);
    // by using automatic new memory is allocated for each function call
    //automatic - function execution happens in different memory location
    function integer fact(input integer a); //static - function execution happens in same memory location
        
        
        begin
            if (a>1) begin
                fact = a * fact(a-1);
            end
            else fact = 1;
        end
    endfunction
endmodule
