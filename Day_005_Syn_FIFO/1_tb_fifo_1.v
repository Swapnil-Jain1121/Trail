`include "1_fifo.v"
module tb_fifo();
    
    parameter DEPTH = 16, WIDTH = 8, PTR_WIDTH = 4;
    
    reg  clk_i, rst_i, wr_en_i, rd_en_i;
    reg [WIDTH - 1 : 0] wdata_i;
    
    wire [WIDTH - 1 : 0] rdata_o;
    wire wr_error_o, full_o, empty_o, rd_error_o;
    
    
    
    integer i;
    
    fifo dut(clk_i, rst_i, wdata_i, wr_en_i, wr_error_o,full_o, rdata_o, rd_en_i, rd_error_o, empty_o);
    
    //clock generation
    initial begin
        clk_i            = 0;
        forever #5 clk_i = ~clk_i;
        //dont code anything after forever, bcz it wont get executed ever
    end
    
    //rst apply and releas
    initial begin
        rst_i = 1; //applying
        
        //when applying rst, make all inputs to zero
        wr_en_i = 1'b0;
        rd_en_i = 1'b0;
        wdata_i = 1'b0;
        
        @(posedge clk_i); //holding
        rst_i = 0; //releasing
        
        //apply stimulus/inputs
        //write to fifo
        write_fifo();
        
        //read from fifo
        read_fifo();
        #50;
        $finish;
    end
    
    task write_fifo();
        begin
            for(i = 0; i <DEPTH; i = i+1) begin
                @(posedge clk_i);
                wr_en_i = 1'b1;
                wdata_i = $random;
            end
            @(posedge clk_i);
            wr_en_i = 1'b0;
            wdata_i = 0;
        end
    endtask
    
    task read_fifo();
        begin
            for(i = 0; i <DEPTH; i = i+1) begin
                @(posedge clk_i);
                rd_en_i = 1'b1;
            end
            @(posedge clk_i);
            rd_en_i = 1'b0;
        end
    endtask
    
    
    
endmodule
