# Washing-Machine-Controller
#### The repository has my design and my implementation for a washing machine controller. The operation of the machine consists of the following states:
- Idle
- Filling water
- Washing
- Rinsing
- Spinning
<hr/>
<b> The input clock can have 1 of 4 frequencies, encoded by the clk_freq[1:0] input port. The frequnecies are:</b>
<br/>
1. 1MHz
<br/>
2. 2MHz
<br/>
3. 4MHz
<br/>
4. 8MHz
<hr/>
<b> How it works:</b>
<br/>
- The machine starts when a coin is deposited.
<br/>
- There is a double wash input, when it is turned on, a second wash and rinse to occur after completing the first rinse.
<br/>
- If the timer_pause flag is asserted during the spin cycle, the machine stops spinning until the flag is de-asserted. The machine is designed to stop when this flag     is raised only during the spin cycle.
<hr/>
<b> The duration of each state:</b>
<br/>
1. Filling water takes 2minutes
<br/>
2. Washing takes 5minutes
<br/>
3. Rinsing takes 2minutes
<br/>
4. Spinning takes 1minutes
<hr/>
<b> About the design:</b>
<br/>
The design mainly consists of 2 blocks, and they communicate together. The first block is a timer, and the second one is a FSM. The FSM sends a certain time to the timer and, based on the value of clk_freq[1:0] the timer will decide whether to count the time sent by the FSM in a certain register or shift this number—to avoid using a multiplier—to get a proper value to be counted based on the frequency on which the controller works. When the timer is done with the counting process, it will assert a flag, and this flag is an input to the FSM, so that the FSM will move to the next state and send the time of this state to the timer. For the double wash program, there is a flag in the FSM so that when the double wash program input is asserted, this flag is asserted to prevent the controller from entering an infinite loop.
