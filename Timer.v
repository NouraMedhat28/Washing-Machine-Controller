module Timer (
    input  wire        rst,
    input  wire        enable,
    input  wire        next_programm_started,
    input  wire [1:0]  ClkFreq,
    input  wire        clk,
    input  wire [31:0] value,
    output reg         current_programm_done
);

reg  [31:0] counter1;
reg  [31:0] counter;

always @(negedge rst or posedge clk) begin
    if(!rst || next_programm_started) begin
        current_programm_done <= 'b0;
        counter         <= 'b0;
    end

    else if (enable) begin
         if (counter1 == 'd1) begin
        current_programm_done <='b1;
        end  

        else begin
        current_programm_done <= 'b0;
        counter1         <= counter1 - 'd1;
        end  

    end

    else begin
        counter1 <= counter1;
    end
end

always @(*) begin
    case (ClkFreq) 
        'b00 : begin
            counter = value;
          
        end

        'b01 : begin
            counter = value<<1;
        end

        'b10 : begin
            counter = value<<2;
        end

        'b11 : begin
            counter = value<<3;
        end

        default : begin
            counter ='b0000; 
        end
    endcase 
    counter1 = counter;
end

endmodule
