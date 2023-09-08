module tb();
    integer intA[9:0];
    integer i,j, num;
    reg num_exists_f;
    
    initial begin
        num_exists_f = 0;
        for(i = 0;i<10;) begin
            num          = $urandom_range(40,49);
            num_exists_f = 0; //start with assumption, number is not present in the array
            for(j = 0; j<i ;j = j+1) begin
                if (intA[j] == num) begin
                    num_exists_f = 1;
                    j            = i; //it will exit the loop
                    
                end
            end
            
            if (num_exists_f == 0) begin
                intA[i] = num;
                i       = i+1;
            end
        end
        for (i = 0; i<10; i = i+1) begin
            $display("intA[%0d] = %0d", i, intA[i]);
        end
    end
endmodule
