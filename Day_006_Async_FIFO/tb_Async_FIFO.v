`include"Async_FIFO.v"
// `include"Async_FIFO_gray.v"

module tb_Async_FIFO();
    
    parameter DEPTH     = 16, WIDTH     = 8, PTR_WIDTH     = 4;
    parameter wr_clk_TP = 10, rd_clk_TP = 14;
    
    
    //common signals
    reg wr_clk_i, rd_clk_i;
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
    
    integer q,i,j,k;
    integer wr_delay, rd_delay;
    
    reg [30*8:1] test_name;
    
    Async_FIFO dut (wr_clk_i,rd_clk_i,rst_i,wr_en_i,wdata_i,full_o,wr_error_o,rd_en_i,rdata_o,empty_o,rd_error_o);
    
    //wr clock generation
    initial begin
        wr_clk_i                          = 0;
        forever #(wr_clk_TP/2.0) wr_clk_i = ~wr_clk_i;
    end
    
    //rd clock generation
    initial begin
        rd_clk_i                          = 0;
        forever #(rd_clk_TP/2.0) rd_clk_i = ~rd_clk_i;
    end
    
    //apply rst and stimulus
    initial begin
        $value$plusargs("test_name=%s",test_name);
        rst_i   = 1; //applying
        //when applying rst make all inputs to zero
        wr_en_i = 0;
        rd_en_i = 0;
        wdata_i = 0;
        
        @(posedge wr_clk_i); //holding
        rst_i = 0; //releasing
        
        
        //apply stimulus
        //testcases
        
        // write_fifo(DEPTH/2);
        // read_fifo(DEPTH/2);
        
        case (test_name)
            "test_full" : begin
                write_fifo(DEPTH);
            end
            "test_empty" : begin
                write_fifo(DEPTH/2);
                read_fifo(DEPTH/2);
            end
            "test_full_error" : begin
                write_fifo(DEPTH + 1);
            end
            "test_empty_error" : begin
                write_fifo(DEPTH);
                read_fifo(DEPTH + 1);
            end
            "test_concurrent_wr_rd" : begin
                fork
                begin
                    for(j = 0; j<10; j = j+1) begin
                        write_fifo(1);
                        wr_delay = $urandom_range(1,10);
                        repeat(wr_delay) @(posedge wr_clk_i);
                    end
                end
                begin
                    for(k = 0; k<10; k = k+1) begin
                        read_fifo(1);
                        rd_delay = $urandom_range(1,10);
                        repeat(wr_delay) @(posedge rd_clk_i);
                    end
                end
                join
                
            end
        endcase
        #50;
        $finish;
    end
    
    task write_fifo(input integer num_wr);
        begin
            for(i = 0; i<num_wr; i = i + 1) begin
                @(posedge wr_clk_i);
                wr_en_i = 1;
                wdata_i = $random;
            end
            @(posedge wr_clk_i);
            wr_en_i = 0;
            wdata_i = 0;
        end
    endtask
    
    task read_fifo(input integer num_rd);
        begin
            for(q = 0; q<num_rd; q = q + 1) begin
                @(posedge rd_clk_i);
                rd_en_i = 1;
            end
            @(posedge rd_clk_i);
            rd_en_i = 0;
        end
    endtask
    
endmodule
