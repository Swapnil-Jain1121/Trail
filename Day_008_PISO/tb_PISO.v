`include"PISO.v"
module tb_PISO();
    
    parameter S_FIFO_EMPTY            = 3'b001;
    parameter S_RD_FIFO               = 3'b010;
    parameter S_DRIVE_SERIAL_INTERFCE = 3'b100;
    
    reg pclk_i, rst_i, sclk_i;
    reg [7:0] data_i;
    reg valid_i;
    wire ready_o;
    wire data_o;
    wire valid_o;
    reg ready_i;
    
    PISO dut (pclk_i,
    rst_i,
    sclk_i,
    data_i,
    valid_i,
    ready_o,
    data_o,
    valid_o,
    ready_i);
    
    integer i;
    initial begin
        pclk_i             = 0;
        forever #10 pclk_i = ~pclk_i;
    end
    
    initial begin
        sclk_i            = 0;
        forever #1 sclk_i = ~sclk_i;
    end
    
    //apply stimulus
    initial begin
        rst_i = 1;
        repeat(2) @(posedge sclk_i);
        rst_i = 0;
        
        //start driving parallel data in to the design
        for(i = 0; i <10; i = i+1) begin
            @(posedge pclk_i);
            data_i[i]     = $random;
            valid_i       = 1;
            wait (ready_o == 1);
        end
        @(posedge pclk_i);
        data_i  = 0;
        valid_i = 0;
        #500;
        $finish;
    end
    
    always @(sclk_i) begin
        if (valid_o) ready_i = 1;
        else ready_i         = 0;
    end
endmodule
