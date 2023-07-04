//to detect the patter of Bike Bike Car Bike Car (BBCBC - 00101)
//mealy design

module pattern_det(clk,
                   rst,
                   d_in,
                   valid_in,
                   pattern_detected);
    
    parameter S_RST      = 3'b000;
    parameter S_B        = 3'b001;
    parameter S_BB       = 3'b010;
    parameter S_BBC      = 3'b011;
    parameter S_BBCB     = 3'b100;
    // parameter S_BBCBC = 3'b101;
    parameter B          = 1'b0;
    parameter C          = 1'b1;
    
    
    input clk, rst, d_in, valid_in;
    output reg pattern_detected;
    
    
    //3FFfor each state
    reg [2:0] state, next_state;
    
    always @(posedge clk) begin
        if (rst == 1) begin
            //all reg variable make them 0  or reset value
            pattern_detected = 0;
            state            = S_RST;
            next_state       = S_RST;
        end
        
        else begin
        pattern_detected = 0;
        if (valid_in == 1) begin
            case(state)
                S_RST: begin
                    if (d_in == B) next_state        = S_B;
                    else next_state = S_RST;
                end
                
                S_B: begin
                    if (d_in == B) next_state        = S_BB;
                    else next_state = S_RST;
                end
                
                S_BB: begin
                    if (d_in == B) next_state        = S_BB;
                    else next_state = S_BBC;
                end
                
                S_BBC: begin
                    if (d_in == B) next_state        = S_BBCB;
                    else next_state = S_RST;
                end
                
                S_BBCB: begin
                    if (d_in == B) begin
                        next_state = S_BB;
                    end
                    else begin next_state = S_RST;
                    pattern_detected      = 1'b1;
                end
            end
            
            default: begin
                $display("Error");
                next_state = S_RST;
            end
            
            endcase
            
        end
        
    end
    end
    
    always @(next_state) begin
        state = next_state;
    end
    
endmodule
