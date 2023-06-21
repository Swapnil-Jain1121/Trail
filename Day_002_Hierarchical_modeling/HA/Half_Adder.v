module half_adder(Sum,
                  Carry,
                  A,
                  B);
    input A,B;
    output Sum, Carry;
    
    assign Sum   = A ^ B;
    assign Carry = A & B;
    
endmodule
