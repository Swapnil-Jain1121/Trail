`include "SPI_ctrl.v"

module tb_SPI_ctrl();
    
    reg pclk_i, prst_i,pwrite_i, penable_i;
    reg [7:0] paddr_i;
    reg [7:0] pwdata_i; //my registers are 8 bit, so addr and data need to be of 8 bits
    wire [7:0] prdata_o;
    wire pready_o;
    reg sclk_ref_i;
    
    wire sclk_o;
    wire mosi;
    reg miso;
    wire [3:0] cs;
    
    parameter NUM_TXN     = 8;
    parameter TP_APB_CLK  = 5;
    parameter TP_SPI_CLK  = 1;
    parameter MAX_NUM_TXS = 8;
    
    
    integer i;
    reg [7:0] data;
    
    SPI_ctrl dut (pclk_i,
    prst_i,
    paddr_i,
    pwdata_i,
    prdata_o,
    pwrite_i,
    penable_i,
    pready_o,
    sclk_ref_i,
    sclk_o,
    mosi,
    miso,
    cs);
    
    initial begin
        pclk_i                           = 0;
        forever #(TP_APB_CLK/2.0) pclk_i = ~pclk_i;
    end
    
    initial begin
        sclk_ref_i                           = 0;
        forever #(TP_SPI_CLK/2.0) sclk_ref_i = ~sclk_ref_i;
    end
    
    initial begin
        prst_i = 1;
        miso = 1;
        paddr_i   = 0;
        pwdata_i  = 0;
        pwrite_i  = 0;
        penable_i = 0;
        data = 0;
        repeat(2) @(posedge pclk_i);
        prst_i = 0;
        //stimulus generation: register programming is the only stimulus generation
        // program addr_regA, data_regA , cntrl_reg = > SPI will automatically do the transactions
        for(i = 0; i <MAX_NUM_TXS; i = i+1) begin
            //programming addr_regA
            write_reg(i, 8'hd3+i); //so we need to write 53 as a address, so writing it as d3 bcz making MSB as 1 for writing
            //so we are writing 53,54... so on
            
            //programming data_regA
            write_reg(8'h10, 8'h46+i);
            
            //ctrl_reg
            data = {4'b0,3'h2 ,1'b1}; //This will result in 3 transactions
            write_reg(8'h20,data);
            
            #500;
            $finish;
            
        end
        
    end
    
    task write_reg(input reg [7:0] addr, input reg [7:0] data);
        begin
            @(posedge pclk_i);   //at the positive edge of clock
            paddr_i        = addr;
            pwdata_i       = data;
            pwrite_i       = 1;
            penable_i      = 1;
            wait (pready_o == 1);
            @(posedge pclk_i);
            paddr_i   = 0;
            pwdata_i  = 0;
            pwrite_i  = 0;
            penable_i = 0;
        end
        endtask

        
        endmodule
