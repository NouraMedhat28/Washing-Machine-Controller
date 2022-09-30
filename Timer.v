module Timer (
    input  wire        rst,
    input  wire        next_programm_started,
    input  wire [1:0]  ClkFreq,
    input  wire        clk,
    input  wire [31:0] value,
    output reg         current_programm_done
);

reg  [31:0] counted_value = 'd0;
reg  [31:0] counter;

always @(negedge rst or posedge clk) begin
    if(!rst||next_programm_started) begin
        current_programm_done <= 'b0;
        counted_value         <= 'b0;
    end


    else if(counter == 0) begin
        current_programm_done <='b1;
    end

    else begin
        current_programm_done <= 'b0;
        counter         <= counter - 'd1;
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
end
endmodule
