//addition of array
module tb();
    reg [3:0] Sum;
    reg Cout;
    reg a,b,cin;
    
    
    initial begin
        repeat(5) begin
            a           = 15;
            b           = 0;
            cin         = 5;
            {Cout, Sum} = fa(a,b,cin);
            $display("a = %0d, b = %0d, cin = %0d, Sum = %0d, Carry_out = %0d",a,b,cin, Sum, Cout);
            
        end
    end
    
    function reg [4:0] fa(input reg [3:0] a, input reg [3:0] b, input reg cin);
        begin
            fa = a + b + cin;
        end
    endfunction
    
endmodule
