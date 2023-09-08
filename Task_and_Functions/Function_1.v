module tb();
    integer p,q,r,s;
    
    initial begin
        p = 10;q = 10;
        //r = p+q
        r = add(p,q);
        s = subs(p,q);
        
        $display("r = %0d",r);
        $display("s = %0d",s);
        
    end
    
    function integer add(input integer a, input integer b); //all function arguments are compulsory ino = put arguments, function output arguments are not possible
        //begin and end is compulsory
        begin
            add = a+b; //output of the function is always assigned to function name itself.
        end
    endfunction
    
    function integer subs(input integer a, input integer b);
        begin
            subs = a-b; //output of the function is always assigned to function name itself.
        end
    endfunction
    
endmodule
