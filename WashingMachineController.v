module WashingMachineController #(
    parameter    FillingTime = 'd1,
                 WashingTime = 'd3,
                 RinsingTime = 'd1,
                 SpiningTime = 'd6
)
(
    input   wire         clk,
    input   wire         rst_n,
    input   wire  [1:0]  ClkFreq,
    input   wire         coin_in,
    input   wire         time_pause,
    input   wire         double_wash,
    output  wire         wash_done
);

wire [31:0]  state_time;
wire         state_done;
wire         next_state_flag;
wire         timerEn;


FSM                          #(.FillingTime(FillingTime), .WashingTime(WashingTime), .RinsingTime(RinsingTime), .SpiningTime(SpiningTime)) FSM_TOP
( .clk                        (clk),
  .rst_n                      (rst_n),
  .coin_in                    (coin_in),
  .timer_pause                (time_pause),
  .wash_done                  (wash_done),
  .state_done                 (state_done),
  .state_time                 (state_time),
  .double_wash                (double_wash),
  .next_state_flag            (next_state_flag),
  .timer_enable               (timerEn)
);
    
Timer                         Timer_Top
( .clk                        (clk),
  .rst                        (rst_n),
  .value                      (state_time),
  .ClkFreq                    (ClkFreq),
  .next_programm_started      (next_state_flag),
  .current_programm_done      (state_done),
  .enable                     (timerEn)
);




endmodule