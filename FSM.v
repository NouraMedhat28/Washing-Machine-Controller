module FSM #(
       parameter FillingTime = 'd120000000,
                 WashingTime = 'd300000000,
                 RinsingTime = 'd120000000,
                 SpiningTime = 'd60000000
)
 (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        state_done,
    input  reg         coin_in,
    input  wire        double_wash,
    input  wire        timer_pause,
    output reg  [31:0] state_time,
    output reg         next_state_flag,
    output reg         timer_enable,
    output reg         wash_done
);


reg [2:0] present_state, next_state;
reg       double_wash_done;

//States Encoding
localparam        idle    = 3'b000,
                  filling = 3'b001,
                  washing = 3'b011,
                  rinsing = 3'b010,
                  spining = 3'b110;

//state transition (sequential always)
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        present_state <= idle;
        wash_done = 'b0;
    end

    else begin
       present_state <= next_state;
    end
end

//next state logic (comb always)
always @(*) begin
    case (present_state)
      idle  :  begin
        if(coin_in) begin
           // coin_in_value = coin_in;
            timer_enable = 'b1;
            next_state = filling;
            next_state_flag = 'b1;
            state_time = FillingTime;
            double_wash_done = 'b0;
        end
        else begin
            next_state = idle;
            next_state_flag = 'b1;
            state_time = 'd0;
        end
      end 

      filling : begin
         if(!state_done) begin
            next_state = filling;
            next_state_flag = 'b0;
        end
        else begin
            next_state = washing;
            next_state_flag = 'b1;
            state_time = WashingTime;
        end
      end

      washing : begin
         if(!state_done) begin
            next_state = washing;
            next_state_flag = 'b0;
        end
        else  begin
            next_state = rinsing;
            next_state_flag = 'b1;
            state_time = RinsingTime;
        end
      end

      rinsing : begin
         if(!state_done) begin
            next_state = rinsing;
            next_state_flag = 'b0;
        end
        else if (double_wash && !double_wash_done) begin
            next_state = washing; 
            next_state_flag = 'b1;
            state_time = WashingTime;
            double_wash_done = 'b1;
        end
        else  begin
            next_state = spining;
            next_state_flag = 'b1;
            state_time = SpiningTime;
        end
      end

      spining : begin
        if (!state_done) begin
            if (!timer_pause) begin
                next_state = spining;
                next_state_flag = 'b0;
                timer_enable = 'b1;
            end
            
            else begin
                timer_enable = 'b0;
                next_state_flag = 'b0;
                next_state = spining;
            end
        end

        else begin
            next_state = idle;
        end
      end
      
        default: begin
            next_state = idle;
        end
    endcase
end

//output logic (comb always)
always @(*) begin
    case(present_state)
    spining : begin
        if(state_done) begin
            wash_done = 'b1;
        end
    end

    default : begin
        wash_done = 'b0;
    end
    endcase
end


endmodule