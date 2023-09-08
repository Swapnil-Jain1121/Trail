module tb();
integer a, seed;

initial begin
    $value$plusargs("seed=%d",seed);
    repeat(4) begin 
        a=$random(seed);
        $display("a=%d",a);
    end
end

endmodule