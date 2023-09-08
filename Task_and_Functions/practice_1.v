module practice();
    
    integer in1,in2, sum_out, sub_out;
    
    initial
    begin
        in1     = 10;
        in2     = 20;
        sum_out = sum(in1, in2);
        sub_out = sub(in1, in2);
        
        $display("in1 = %0d,in1 = %0d, sum = %0d", in1, in2, sum_out);
        $display("in1 = %0d,in1 = %0d, sum = %0d", in1, in2, sub_out);
        
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
