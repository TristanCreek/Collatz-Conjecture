# CollatzConjecture
Collatz Conjecture - If the number is even, divide by two. If the number is odd, multiply by 3 and add 1. It is speculated, but not proven, that this algorithm converges to 1 for all numbers.

Thirteen switches for number input, allowing for input up to 8192.
Three switches to start, pause, and reset.

The collatz conjecture is an interesting problem because, although a rather trivial calculation, there is no mathematical proof of convergence. It has been experimentally proven that all numbers up to 5\*2^60 do converge, but there is yet a proof that every single number will converge to 1.

The FPGA board is an interesting platform to expression this problem on due to the growth with each cycle. Some numbers grow relatively large, and some numbers take many cycles to converge. The FPGA board is a quick and easy way to input a number and see how quickly it converges in real time.

Examples:
Input - Cycles Until Convergence - Outcome
6171 - 261 cycles - overflow
871 - 178 cycles - overflow
97 - 118 cycles - converges to 1

Schematic of Collatz Conjecture architecture implemented in Verilog on a Basys3 FPGA
![alt text](https://github.com/TristanCreek/Collatz-Conjecture/blob/master/schematic.png)
