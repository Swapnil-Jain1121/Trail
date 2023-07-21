module memory(clk_i,
              rst_i,
              addr_i,
              wdata_i,
              rdata_o,
              wr_en_i,
              rd_en_i);
    //1kb memory with 16 bit width
    //width = 16, depth = 64, addr_width = 6
    parameter WIDTH      = 16;
    parameter DEPTH      = 16;
    parameter ADDR_WIDTH = 16;
    
    input clk_i, rst_i;
    input [ADDR_WIDTH-1:0] addr_i;
    input [WIDTH-1:0] wdata_i;
    output reg [WIDTH-1:0] rdata_o;
    input wr_en_i;
    input rd_en_i;
    
    reg [WIDTH-1:0] mem[DEPTH-1:0];
    
    always @(posedge clk_i) begin
        if (rst_i == 1) begin
            rdata_o = 0;
            for (i  = 0;i<DEPTH;i  = i+1) mem[i]  = 0;
        end
        else begin
            if (wr_en_i == 1) mem[addr_i]          = wdata_i;
            if (rd_en_i) rdata_o = mem[addr_i];
        end
    end
    
    
endmodule
