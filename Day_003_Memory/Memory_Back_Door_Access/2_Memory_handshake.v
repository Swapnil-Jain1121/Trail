module memory(clk_i,
              rst_i,
              addr_i,
              wdata_i,
              rdata_o,
              wr_rd_i,
              valid_i,
              ready_o);
    //1kb memory with 16 bit width
    //width = 16, depth = 64, addr_width = 6
    parameter WIDTH      = 16;
    parameter DEPTH      = 64;
    parameter ADDR_WIDTH = 16;
    
    input clk_i, rst_i;
    input [ADDR_WIDTH-1:0] addr_i;
    input [WIDTH-1:0] wdata_i;
    output reg [WIDTH-1:0] rdata_o;
    input wr_rd_i;
    input valid_i;
    output reg ready_o;
    integer i;
    
    
    reg [WIDTH-1:0] mem[DEPTH-1:0];
    
    always @(posedge clk_i) begin
        if (rst_i == 1) begin
            rdata_o = 0;
            ready_o = 0;
            for (i  = 0;i<DEPTH;i  = i+1) mem[i]  = 0;
        end
        else begin
            if (valid_i == 1) begin
                ready_o      = 1;
                if (wr_rd_i == 1) mem[addr_i]  = wdata_i;
                else rdata_o = mem[addr_i];
            end
            
            else begin
            ready_o = 0;
        end
    end
    end
    
endmodule
