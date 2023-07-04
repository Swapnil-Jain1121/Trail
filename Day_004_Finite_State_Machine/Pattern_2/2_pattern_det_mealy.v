//to detect the patter of Bike Car Car Car Bike (BCCCB - 01110)
//mealy design

module pattern_det(clk,
                   rst,
                   d_in,
                   valid_in,
                   pattern_detected);
    
    parameter S_RST      = 3'b000;
    parameter S_B        = 3'b001;
    parameter S_BC       = 3'b010;
    parameter S_BCC      = 3'b011;
    parameter S_BCCC     = 3'b100;
    // parameter S_BCCCB = 3'b101;
    parameter B          = 1'b0;
    parameter C          = 1'b1;
    
    input clk, rst, d_in, valid_in;
    output reg pattern_detected;
    
    reg [2:0] state, next_state;
    
    always @(posedge clk) begin
        if (rst == 1) begin
            pattern_detected = 1'b0;
            state            = S_RST;
            next_state       = S_RST;
        end
        else begin
            pattern_detected = 1'b0;
            if (valid_in == 1) begin
                case(state)
                    S_RST: begin
                        if (d_in == B) next_state         = S_B;
                        else  next_state = S_RST;
                    end
                    
                    S_B: begin
                        if (d_in == B) next_state         = S_B;
                        else  next_state = S_BC;
                    end
                    
                    S_BC: begin
                        if (d_in == B) next_state         = S_B;
                        else  next_state = S_BCC;
                    end
                    
                    S_BCC: begin
                        if (d_in == B) next_state         = S_B;
                        else  next_state = S_BCCC;
                    end
                    
                    S_BCCC: begin
                        if (d_in == B) begin next_state         = S_B;
                        pattern_detected = 1'b1;
                    end
                    else begin  next_state = S_RST;
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
    
