`include"Async_FIFO.v"
module PISO(pclk_i,
            rst_i,
            sclk_i,
            data_i,
            valid_i,
            ready_o,
            data_o,
            valid_o,
            ready_i);
    
    input pclk_i, rst_i, sclk_i;
    input [7:0] data_i;
    input valid_i;
    output reg ready_o;
    output reg data_o;
    output reg valid_o;
    input ready_i;
    
    reg wr_en_t;
    reg [7:0] wr_data_t;
    wire full_t;
    wire wr_error_t;
    reg rd_en_t;
    wire [7:0] rd_data_t;
    wire empty_t;
    wire rd_error_t;
    reg full_o;
    reg empty_o;
    reg rd_en_i;
    
    integer count;
    integer i;
    reg state, next_state;
    
    parameter S_FIFO_EMPTY            = 3'b001;
    parameter S_RD_FIFO               = 3'b010;
    parameter S_DRIVE_SERIAL_INTERFCE = 3'b100;
    
    //block_1
    //glue logic
    
    always @(*) begin
        if (valid_i == 1 && full_o == 0) begin
            wr_en_t   = 1;
            wr_data_t = data_i;
            ready_o   = 1;
        end
        else begin
            wr_en_t = 0;
            ready_o = 0;
        end
    end
    
    //block_2
    Async_FIFO dut(.wr_clk_i(pclk_i),
    .rd_clk_i(sclk_i),
    .rst_i(rst_i),
    .wr_en_i(wr_en_t),
    .wdata_i(wr_data_t),
    .full_o(full_t),
    .wr_error_o(wr_error_t),
    .rd_en_i(rd_en_t),
    .rdata_o(rd_data_t),
    .empty_o(empty_t),
    .rd_error_o(rd_error_t));
    
    
    //block_3
    always @(posedge sclk_i) begin
        if (rst_i == 1) begin
            ready_o   = 0;
            data_o    = 0;
            valid_o   = 0;
            wr_en_t   = 0;
            wr_data_t = 0;
            rd_en_t   = 0;
        end
        else begin
            case (state)
                S_FIFO_EMPTY: begin
                    if (empty_o == 0) begin //not empty then read from FIFO
                        next_state = S_RD_FIFO;
                        rd_en_i    = 1;
                    end
                end
                
                S_RD_FIFO: begin
                    rd_en_i    = 0;
                    next_state = S_DRIVE_SERIAL_INTERFCE;
                    count      = 0;
                end
                
                S_DRIVE_SERIAL_INTERFCE: begin
                    data_o             = rd_data_t[count];
                    valid_o            = 1;
                    if (ready_i) count = count + 1;
                    if (count == 8) begin //driving all serial 8 bits
                        valid_o         = 0;
                        count           = 0;
                        if (empty_t == 1) next_state     = S_FIFO_EMPTY;
                        else next_state = S_RD_FIFO;
                    end
                    
                end
            endcase
            
        end
    end
    
    always @(next_state) state = next_state;
    
endmodule
