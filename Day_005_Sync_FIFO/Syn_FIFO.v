module FIFO(clk_i,
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
    input clk_i;
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
    
    reg wr_toggle_f;
    reg rd_toggle_f;
    
    always @(posedge clk_i) begin
        if (rst_i == 1) begin
            //make all registers value to zero
            full_o      = 0;
            empty_o     = 1;
            wr_error_o  = 0;
            rd_error_o  = 0;
            rdata_o     = 0;
            wr_ptr      = 0;
            rd_ptr      = 0;
            wr_toggle_f = 0;
            rd_toggle_f = 0;
            
            for(i = 0; i <DEPTH; i = i + 1) begin
                memory[i] = 1;
            end
        end
        else begin
            //2 processes
            //write to FIFO
            
            wr_error_o = 0;
            rd_error_o = 0;
            
            if (wr_en_i == 1) begin
                if (full_o == 1) begin
                    wr_error_o = 1;
                end
                else begin
                    memory[wr_ptr] = wdata_i;
                    if (wr_ptr == DEPTH-1) begin 
                    wr_toggle_f = ~wr_toggle_f;
                    end
                    wr_ptr = wr_ptr + 1;
                end
            end
            
            //read from FIFO
            
            if (rd_en_i == 1) begin
                if (empty_o == 1) begin
                    rd_error_o = 1;
                end
                else begin
                    rdata_o    = memory[rd_ptr];
                    if (rd_ptr == DEPTH-1) begin 
                    rd_toggle_f = ~rd_toggle_f;
                    end
                    rd_ptr = rd_ptr + 1;
                end
            end
        end
        
    end
    
    //logic to decide full and empty
    
    always @(*) begin
        empty_o = 0;
        full_o  = 0;
        
        if (wr_ptr == rd_ptr) begin
            if (wr_toggle_f == rd_toggle_f) empty_o = 1;
            if (wr_toggle_f != rd_toggle_f) full_o = 1;
        end
    end
    
endmodule
