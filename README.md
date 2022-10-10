# Washing-Machine-Controller
#### The repository has my design and my implementation for a washing machine controller. The operation of the machine consists of the following states:
- Idle
- Filling water
- Washing
- Rinsing
- Spinning
<hr/>
<b> The input clock can have 1 of 4 frequencies, encoded ny the clk_freq[1:0] input port. The frequnecies are:</b>
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
- There is a double wash input, when it is turned on, a second wash and rinse to occur after completing the first rinse.
- If the timer_pause flag is asserted during the spin cycle, the machine stops spinning until the flag is de-asserted. The machine is designed to stop when this flag is   raised only during the spin cycle.
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

