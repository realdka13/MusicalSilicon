`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Donovan Magney
//
// Create Date: 09/05/2023 11:04:24 AM
// Module Name: PWMChannel
// Project Name: MusicalSilicon
// Target Devices:
// Tool Versions: Vivado 2023.1
// Description: A signle audio channel, which outputs a changing PWM signal
//////////////////////////////////////////////////////////////////////////////////

/*
*****Frequency*****
counterMax = f_clk/(DIVISOR * f_pwm)
f_pwm = f_clk/(DIVISOR * counterMax)

*****Freq Precision*****
Plug in f_pwm = f_clk/(DIVISOR * counterMax) into a graphing calculator. High freq have lower precision than lower freq

*****Duty Cycle*****
The duty cycle is the counter value at which the output switches from high to low
Duty Cycle must be 1 bit larger than counterMax to avoid a single clk cycle drop when at 100% duty cycle
For 100% duty cycle, add 1 to the max counter value

*****Parameters*****
COUNTEBITS: The amount of bits required for the counter.
    Default: 16, for a max value of 65536
DIVISOR: Divide the clock frequency by this parameter
    Default: 1, the clock is passed through and has the highest high freq precision
*/

module PWMChannel
  #(parameter COUNTERBITS = 16, DIVISOR = 1)(
  input clk, reset,

  input [COUNTERBITS-1:0]counterMax,
  input [COUNTERBITS:0] dutyCycle,

  output PWM
  );

  //#############################################################
  //Regs & Wires
  //#############################################################

  wire divided_clk;

  //#############################################################
  //Logic
  //#############################################################

  CLK_DIV #(DIVISOR) clockDiv(.clk_in(clk), .reset(reset), .clk_out(divided_clk));
  PWM_Generator #(COUNTERBITS) PWMGen(.clk(divided_clk), .reset(reset), .counterMax(counterMax), .dutyCycle(dutyCycle), .PWM(PWM));

endmodule
