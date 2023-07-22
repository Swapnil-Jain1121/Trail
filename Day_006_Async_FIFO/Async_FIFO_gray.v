module Async_FIFO(wr_clk_i,
                  rd_clk_i,
                  rst_i,
                  wr_en_i,
                  wdata_i,
                  full_o,
                  wr_error_o,
                  rd_en_i,
                  rdata_o,
                  empty_o,
                  rd_error_o);
    
    parameter DEPTH = 16, WIDTH = 8, PTR_WIDTH = 4;
    
    //common signals
    input wr_clk_i, rd_clk_i;
    input rst_i;
    
    //write interface
    input wr_en_i;
    input [WIDTH-1:0] wdata_i;
    output reg full_o;
    output reg wr_error_o;
    
    //read interface
    input rd_en_i;
    output reg [WIDTH-1:0] rdata_o;
    output reg empty_o;
    output reg rd_error_o;
    
    integer i;
    
    //declaring the memory
    reg [WIDTH-1:0] memory [DEPTH-1:0];
    
    //pointers and toggle registers
    reg [PTR_WIDTH-1:0] wr_ptr;
    reg [PTR_WIDTH-1:0] rd_ptr;
    
    reg [PTR_WIDTH-1:0] wr_ptr_gray;
    reg [PTR_WIDTH-1:0] rd_ptr_gray;
    
    reg [PTR_WIDTH-1:0] wr_ptr_rd_clk;
    reg [PTR_WIDTH-1:0] rd_ptr_wr_clk;
    
    reg [PTR_WIDTH-1:0] wr_ptr_gray_rd_clk;
    reg [PTR_WIDTH-1:0] rd_ptr_gray_wr_clk;
    
    reg wr_toggle_f;
    reg rd_toggle_f;
    reg wr_toggle_f_rd_clk;
    reg rd_toggle_f_wr_clk;
    
    
    //write to FIFO
    always @(posedge wr_clk_i) begin
        if (rst_i == 1) begin
            //make all registers value to zero
            full_o             = 0;
            empty_o            = 1;
            wr_error_o         = 0;
            rd_error_o         = 0;
            rdata_o            = 0;
            wr_ptr             = 0;
            rd_ptr             = 0;
            wr_ptr_gray        = 0;
            rd_ptr_gray        = 0;
            wr_ptr_rd_clk      = 0;
            rd_ptr_wr_clk      = 0;
            wr_toggle_f        = 0;
            rd_toggle_f        = 0;
            wr_toggle_f_rd_clk = 0;
            rd_toggle_f_wr_clk = 0;
            
            for(i = 0; i <DEPTH; i = i + 1) begin
                memory[i] = 1;
            end
        end
        else begin
            //write to FIFO
            wr_error_o = 0;
            
            if (wr_en_i == 1) begin
                if (full_o == 1) begin
                    wr_error_o = 1;
                end
                else begin
                    memory[wr_ptr] = wdata_i;
                    if (wr_ptr == DEPTH-1) begin
                        wr_toggle_f = ~wr_toggle_f;
                    end
                    wr_ptr      = wr_ptr + 1;
                    wr_ptr_gray = {wr_ptr[3],wr_ptr[3:1] ^ wr_ptr[2:0]};
                    //MSB bit, remaining bit XOR in one bit shifted manner
                end
            end
            
        end
        
    end
    
    
    //read FIFO logic
    
    always @(posedge rd_clk_i) begin
        if (rst_i != 1) begin
            rd_error_o = 0;
            //read from FIFO
            
            if (rd_en_i == 1) begin
                if (empty_o == 1) begin
                    rd_error_o = 1;
                end
                else begin
                    rdata_o = memory[rd_ptr];
                    if (rd_ptr == DEPTH-1) begin
                        rd_toggle_f = ~rd_toggle_f;
                    end
                    rd_ptr      = rd_ptr + 1;
                    rd_ptr_gray = {rd_ptr[3],rd_ptr[3:1]^rd_ptr[2:0]};
                    
                end
            end
        end
        
    end
    
    
    //logic to decide full and empty
    
    always @(*) begin
        empty_o = 0;
        full_o  = 0;
        
        //generating full condition
        if (wr_ptr_gray == rd_ptr_gray_wr_clk) begin
            if (wr_toggle_f != rd_toggle_f_wr_clk) full_o = 1;
        end
        //generating empty condition
        if (wr_ptr_gray_rd_clk == rd_ptr_gray) begin
            if (wr_toggle_f_rd_clk == rd_toggle_f) empty_o = 1;
        end
        
        
        
    end
    
    
    //synchronising wr_ptr w.r.to. rd_clk_i
    always @(posedge rd_clk_i) begin
        wr_ptr_gray_rd_clk <= wr_ptr_gray;
        wr_toggle_f_rd_clk <= wr_toggle_f;
    end
    
    //synchronising rd_ptr w.r.to. wr_clk_i
    always @(posedge wr_clk_i) begin
        rd_ptr_gray_wr_clk <= rd_ptr_gray;
        rd_toggle_f_wr_clk <= rd_toggle_f;
    end
    
endmodule
