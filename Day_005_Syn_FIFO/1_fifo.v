module fifo(clk_i,
            rst_i,
            wdata_i,
            wr_en_i,
            wr_error_o,
            full_o,
            rdata_o,
            rd_en_i,
            rd_error_o,
            empty_o);
    
    parameter DEPTH = 16, WIDTH = 8, PTR_WIDTH = 4;
    
    //declare all inputs and outputs
    input  clk_i, rst_i, wr_en_i, rd_en_i;
    input [WIDTH - 1 : 0] wdata_i;
    
    output reg [WIDTH - 1 : 0] rdata_o;
    output reg wr_error_o, full_o, empty_o, rd_error_o;
    
    //rd_ptr and wr_ptr
    reg [PTR_WIDTH-1:0] wr_ptr, rd_ptr;
    
    //toggle flags are scalars
    reg wr_toggle_f, rd_toggle_f;
    
    //declare the memory
    reg [WIDTH-1:0] mem [DEPTH-1:0];
    
    integer i;
    
    //processes in fifo
    //write, and read = > do they happen in same clock or different = > synchronous = > both can be coded into same always block
    
    always @(posedge clk_i) begin
        if (rst_i == 1) begin
            wr_error_o  = 1'b0;
            full_o      = 1'b0;
            empty_o     = 1'b1;
            rd_error_o  = 1'b0;
            rdata_o     = 8'b0;
            wr_toggle_f = 1'b0;
            rd_toggle_f = 1'b0;
            wr_ptr      = 1'b0;
            rd_ptr      = 1'b0;
            //mem = 0 = > its wrong because its an array
            
            for(i = 0; i<DEPTH; i = i+1) begin
                mem [i] = 0;
            end
            
            
            
            
        end
        else begin //rst_i is not applied
            
            rd_error_o = 1'b0;
            wr_error_o = 1'b0;
            //write can happen
            
            if (wr_en_i == 1) begin
                if (full_o == 1) begin
                    wr_error_o = 1'b1;
                end
                else begin
                    //store data in memory
                    
                    mem[wr_ptr] = wdata_i;
                    
                    //toggle flag during rollover
                    if (wr_ptr == DEPTH-1) wr_toggle_f = ~wr_toggle_f;
                    
                    //increamenting the wr_ptr
                    wr_ptr = wr_ptr + 1;
                    
                end
            end
            
            //read can happen
            
            if (rd_en_i == 1) begin
                if (empty_o == 1) begin
                    rd_error_o = 1'b1;
                end
                else begin
                    //get data from memory
                    
                    //toggle flag during rollover
                    if (rd_ptr == DEPTH-1) rd_toggle_f = ~rd_toggle_f;
                    
                    rdata_o = mem[rd_ptr];
                    //increamenting the rd_ptr
                    rd_ptr = rd_ptr + 1;
                end
            end
            
        end
    end
    
    //logic for empty and full generation
    //can be done in either sequenctial or combination login
    //we choose to do with combination logic
    
    always@(*) begin
        //wr_ptr, rd_ptr, w_toggle_f, r_toggle_f
        empty_o = 0;
        full_o  = 0;
        if (wr_ptr == rd_ptr) begin
            if (wr_toggle_f == rd_toggle_f) empty_o   = 1'b1;
            if (wr_toggle_f != rd_toggle_f) full_o = 1'b1;
        end
        
    end
    
    
endmodule
