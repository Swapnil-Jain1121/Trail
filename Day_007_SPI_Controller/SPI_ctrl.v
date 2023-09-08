module SPI_ctrl(pclk_i,
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
    
    input pclk_i, prst_i,pwrite_i, penable_i;
    input [7:0] paddr_i;
    input [7:0] pwdata_i; //my registers are 8 bit, so addr and data need to be of 8 bits
    output reg [7:0] prdata_o;
    output reg pready_o;
    
    output sclk_o;
    input sclk_ref_i;
    output reg mosi;
    input miso;
    output reg [3:0] cs;
    
    parameter MAX_NUM_TXS = 8;
    integer i;
    integer count   ;

    
    //declare the memory and register
    reg [7:0] addr_regA[MAX_NUM_TXS-1:0]; //'h0 to MAX_NUM_TXS-1(7)
    reg [7:0] data_regA[MAX_NUM_TXS-1:0]; //'h10 to 'h10 + MAX_NUM_TXS-1
    reg [7:0] ctrl_reg; //'h20
    
    reg [4:0] state, next_state;
    reg [2:0] cur_txn_idx;
    reg [3:0] num_txs_pending;
    reg sclk_gated_f;
    
    
    parameter S_IDLE                  = 5'b00001;
    parameter S_ADDRESS               = 5'b00010;
    parameter S_IDLE_BW_ADDR_DATA     = 5'b00100;
    parameter S_DATA                  = 5'b01000;
    parameter S_IDLE_WITH_TXS_PENDING = 5'b10000;
    
    reg [7:0] addr_to_drive, data_to_drive;
    reg [7:0] data_collect; //data coming from SPI slave during the reads.
    
    //how many processes: 2 processes
    //1. programming the registers
    //2. doing the SPI tx
    
    //programming the registers
    always@(posedge pclk_i) begin
        if (prst_i == 1) begin
            prdata_o     = 0;
            pready_o     = 0;
            cs = 4'b1;
            state        = S_IDLE;
            next_state   = S_IDLE;
            sclk_gated_f = 1;
            cur_txn_idx  = 0;
            num_txs_pending = 0;
            addr_to_drive = 0;
            data_to_drive = 0;
            for(i = 0; i <MAX_NUM_TXS; i = i + 1) begin
                addr_regA[i] = 0;
                data_regA[i] = 0;
            end
            ctrl_reg     = 0;
            mosi         = 1;
            data_collect = 0;
        end
        else begin
            if (penable_i == 1) begin
                pready_o = 1;
                //write registers
                if (pwrite_i == 1) begin
                    if (paddr_i >= 8'h0 && paddr_i <= 8'h7) addr_regA[paddr_i] = pwdata_i;
                    if (paddr_i >= 8'h10 && paddr_i <= 8'h17) data_regA[paddr_i-8'h10] = pwdata_i;
                    if (paddr_i == 8'h20) ctrl_reg   = pwdata_i[3:0]; //since upper 4 bits are read only bits
                end
                else begin
                    //read registers
                    if (paddr_i >= 8'h0 && paddr_i <= 8'h7) prdata_o = addr_regA[paddr_i];
                    if (paddr_i >= 8'h10 && paddr_i <= 8'h17) prdata_o = data_regA[paddr_i-8'h10];
                    if (paddr_i == 8'h20) prdata_o   = ctrl_reg;
                end
                
            end
            else
                pready_o = 0;
        end
    end
    
    //2. doing the SPI tx
    
    always @(posedge sclk_ref_i) begin
        if (prst_i == 0) begin
            case(state)
                S_IDLE: begin
                    mosi = 1;
                    sclk_gated_f = 1; //clock is not running
                    if (ctrl_reg[0]) begin //ctrl_reg[0] = 1, enable txn
                        cur_txn_idx     = ctrl_reg[6:4];
                        next_state      = S_ADDRESS;
                        addr_to_drive   = addr_regA[cur_txn_idx];
                        data_to_drive   = data_regA[cur_txn_idx];
                        count           = 0;
                        num_txs_pending = ctrl_reg[3:1] + 1; //+1 relation
                    end
                end
                
                S_ADDRESS: begin
                    sclk_gated_f = 0; //clock is running
                    mosi         = addr_to_drive[count];
                    count        = count + 1;
                    if (count == 8) begin
                        next_state = S_IDLE_BW_ADDR_DATA;
                        count      = 0;
                    end
                end
                
                S_IDLE_BW_ADDR_DATA: begin
                    sclk_gated_f = 1;
                    mosi = 1;

                    //waiting 4 clock cycles between address and data, we are deciding this 4 cycle as a delay
                    count = count + 1;
                    if (count == 4) begin
                        next_state = S_DATA;
                        count      = 0;
                    end
                end
                
                S_DATA: begin
                    sclk_gated_f = 0;
                    if (addr_to_drive[7] == 1) begin  //write
                        //master drives data to slave on mosi
                        mosi  = data_to_drive[count];
                        count = count + 1;
                    end
                    
                    if (addr_to_drive[7] == 0) begin  //read
                        //slaves drives data to mastewr on miso
                        data_collect[count] = miso;
                        count               = count + 1;
                    end
                    
                    if (count == 8) begin
                        num_txs_pending = num_txs_pending - 1; //still these many txns to do
                        count           = 0;
                        ctrl_reg[6:4]   = ctrl_reg[6:4] + 1; //with every txs next txs index should increase
                        cur_txn_idx     = cur_txn_idx + 1;
                        if (num_txs_pending == 0) begin
                            next_state = S_IDLE;
                            ctrl_reg[0] = 0; //making it 0, hence transactions wont happen
                            ctrl_reg[3:1] = 0;

                        end
                        else begin
                            next_state = S_IDLE_WITH_TXS_PENDING;
                        end
                    end
                    
                end
                S_IDLE_WITH_TXS_PENDING: begin
                    sclk_gated_f = 1;
                    mosi = 1;
                    count        = count + 1;
                    if (count == 4) begin
                        next_state = S_ADDRESS;
                        addr_to_drive = addr_regA[cur_txn_idx];
                        data_to_drive = data_regA[cur_txn_idx];
                        count         = 0;
                    end
                end
                       
            endcase
        end
        
        
    end
    
    // always @(sclk_ref_i) begin
    //     if (sclk_gated_f == 1) sclk_o = 1;
    //     else sclk_o = sclk_ref_i
    // end
    
    assign sclk_o = (sclk_gated_f == 1) ? 1 : sclk_ref_i;
    
    always @(next_state) begin
        state = next_state;
    end
    
endmodule
    
