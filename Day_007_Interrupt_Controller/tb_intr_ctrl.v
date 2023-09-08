`include "intr_ctrl.v"
module tb();
    
    reg pclk_i, prst_i, pwrite_i, penable_i, intr_serviced_i;
    reg [7:0] paddr_i, pwdata_i;
    reg [15:0] intr_active_i; //$random = > some bits will be zero some bits will be one
    
    wire [7:0] prdata_o;
    wire [3:0] intr_to_service_o; //16 peripherals NUM_INTR = 16, so we need 4 bits
    wire pready_o, perror_o, intr_valid_o;
    integer i;

    parameter NUM_INTR = 16; //number of peripherals

    
    intr_ctrl dut(.*);
    // intr_ctrl dut(.pclk_i(pclk_i), ...);
    
    
    
    initial begin
        pclk_i            = 0;
        forever #5 pclk_i = ~pclk_i;
    end
    
    initial begin
        prst_i = 1;
        repeat (2) @(posedge pclk_i);
        prst_i = 0;
        
        //stimulus
        //1. Programming of registers
        //2. Generating of interrupts
        
        //1. Programming the registers = > Similar to writing to memory
        for(i = 0; i < NUM_INTR; i = i+1) begin
            write_reg(i,i);
        end //0th peripheral with 0 priority, 1st peripheral with 1 priority... 15th peripheral with 15 priority
        
        
        //2. Generating of interrupts
        intr_active_i = $random; //students have asked the questions
        #500; //taking time to answer all the students
        $finish;
    end
    
    task write_reg(input reg [3:0] addr, input reg [3:0] data);
        begin
            @(posedge pclk_i);
            paddr_i       = addr; //address of the register
            pwdata_i      = data; //priority value
            pwrite_i      = 1;
            penable_i     = 1;
            wait(pready_o == 1);
            paddr_i       = 0; //address of the register
            pwdata_i      = 0; //priority value
            pwrite_i      = 0;
            penable_i     = 0;
        end
    endtask
    
    
    
    
    
endmodule
