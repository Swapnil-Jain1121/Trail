module intr_ctrl(pclk_i,
                 prst_i,
                 paddr_i,
                 pwdata_i,
                 prdata_o,
                 pwrite_i,
                 penable_i,
                 pready_o,
                 perror_o,
                 intr_to_service_o,
                 intr_serviced_i,
                 intr_valid_o,
                 intr_active_i);
    
    //p means APB signals (from processor)
    
    parameter NUM_INTR                   = 16; //number of peripherals
    parameter S_NO_INTR                  = 3'b010;
    parameter S_INTR_ACTIVE              = 3'b100;
    parameter S_INTR_WAITING_FOR_SERVICE = 3'b100;
    
    input pclk_i, prst_i, pwrite_i, penable_i, intr_serviced_i;
    input [7:0] paddr_i, pwdata_i;
    input [15:0] intr_active_i;
    
    output reg [7:0] prdata_o;
    output reg [3:0] intr_to_service_o; //16 peripherals NUM_INTR = 16, so we need 4 bits
    output reg pready_o, perror_o, intr_valid_o;
    
    integer i;
    //registers
    reg [7:0] priority_regA[NUM_INTR-1:0];
    reg [2:0] state, next_state;
    reg first_match_f;
    reg [3:0] current_high_prio;
    reg [3:0] intr_with_high_prio;
    
    //registers programming (same as memory write and read)
    always@(posedge pclk_i) begin
        if (prst_i == 1) begin
            //make all reg variable as zero
            prdata_o          = 0;
            intr_to_service_o = 0;
            pready_o          = 0;
            perror_o          = 0;
            for(i = 0; i <NUM_INTR; i = i+1) begin
                priority_regA[i] = 0;
            end
            state      = S_NO_INTR;
            next_state = S_NO_INTR;
            
        end
        else begin
            if (penable_i == 1) begin
                pready_o = 1;
                if (pwrite_i == 1) begin
                    priority_regA[paddr_i] = pwdata_i;
                end
                else begin
                    prdata_o = priority_regA[paddr_i];
                end
            end
            else begin
                pready_o = 0;
            end
        end
    end
    
    //interrupt handling
    always@(posedge pclk_i) begin
        if (prst_i!= 1) begin
            case(state)
                
                S_NO_INTR: begin
                    //from FSM
                    if (intr_active_i != 0) begin
                        next_state = S_INTR_ACTIVE;
                        first_match_f = 1;
                    end
                end
                
                S_INTR_ACTIVE: begin
                    //what to do when we are in this state?
                    //get the highest priority interrupt among all the active interrupt
                    for(i = 0;i<NUM_INTR;i = i+1) begin
                        if (intr_active_i == 1) begin
                            if (first_match_f == 1) begin
                                current_high_prio   = priority_regA[i];
                                intr_with_high_prio = i;
                                first_match_f       = 0;
                            end
                            else begin
                                if (current_high_prio <priority_regA[i]) begin
                                    current_high_prio   = priority_regA[i];
                                    intr_with_high_prio = i;
                                end
                            end
                        end
                    end
                    //current_high_prio and intr_with_high_prio will be available after the end of for loop
                    
                    intr_to_service_o = intr_with_high_prio;
                    intr_valid_o      = 1;
                    next_state        = S_INTR_WAITING_FOR_SERVICE;
                    
                    //give it to the processor(interrupt with highest priority), then jumpt to next state i.e. wating for it to get services
                end
                
                S_INTR_WAITING_FOR_SERVICE: begin
                    if (intr_serviced_i == 1) begin
                        intr_to_service_o = 0;
                        intr_valid_o      = 0;
                        if (intr_active_i != 0) begin
                            next_state = S_INTR_ACTIVE;
                            first_match_f = 1;
                        end
                        
                        else begin
                            next_state = S_NO_INTR;
                        end
                    end
                end
                
                
            endcase
            
        end
        
    end
    
     always @(next_state) begin
        state = next_state;
        end
    
endmodule
