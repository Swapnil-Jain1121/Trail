`include"Syn_FIFO.v"
module tb_Syn_FIFO();
    
    parameter DEPTH = 16, WIDTH = 8, PTR_WIDTH = 4;
    
    //common signals
    reg clk_i;
    reg rst_i;
    
    //write interface
    reg wr_en_i;
    reg [WIDTH-1:0] wdata_i;
    wire full_o;
    wire wr_error_o;
    
    //read interface
    reg rd_en_i;
    wire [WIDTH-1:0] rdata_o;
    wire empty_o;
    wire rd_error_o;
    
    integer i;
    
    reg [30*8:1] testname;
    
    FIFO dut (clk_i, rst_i, wr_en_i, wdata_i, full_o,
    wr_error_o, rd_en_i, rdata_o, empty_o, rd_error_o);
    
    //clock generation
    initial begin
        clk_i            = 0;
        forever #5 clk_i = ~clk_i;
    end
    
    //apply rst and stimulus
    initial begin
        $value$plusargs("testname=%s",testname);
        rst_i                     = 1; //applying
        //when applying rst make all inputs to zero
        wr_en_i = 0;
        rd_en_i = 0;
        wdata_i = 0;
        
        @(posedge clk_i); //holding
        rst_i = 0; //releasing
        
        //apply stimulus
        //testcases
        
        case (testname)
            "test_full": begin
                write_fifo(DEPTH);
            end
            "test_empty": begin
                write_fifo(DEPTH);
                read_fifo(DEPTH);
            end
            "test_full_error": begin
                write_fifo(DEPTH+1);
            end
            "test_empty_error": begin
                write_fifo(DEPTH);
                read_fifo(DEPTH+1);
            end
            "test_concurrent_wr_rd": begin
            end
        endcase
        #50;
        $finish;
    end
    
    task write_fifo(input integer num_wr);
        begin
            for(i = 0; i<num_wr; i = i + 1) begin
                @(posedge clk_i);
                wr_en_i = 1;
                wdata_i = $random;
            end
            @(posedge clk_i);
            wr_en_i = 0;
            wdata_i = 0;
        end
    endtask
    
    task read_fifo(input integer num_rd);
        begin
            for(i = 0; i<num_rd; i = i + 1) begin
                @(posedge clk_i);
                rd_en_i = 1;
            end
            @(posedge clk_i);
            rd_en_i = 0;
        end
    endtask
    
endmodule
