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


module PWMChannel
  /*
  COUNTEBITS: The amount of bits for the counterMax input. 
  DIVISOR: Divide the clock frequency by this parameter

  F_pwm =  = 1/(T_clk*DIVISOR*COUNTERMAX)
  */
  #(parameter COUNTERBITS = 10, DIVISOR = 1)(
     input clk, reset,

     /*
     Duty cycle bit calculation { (dutyCycle% * (2^BITLENGTH)) - 1 = dutyCycle }
     Duty Cycle must be 1 bit larger than the counter to avoid a single cycle drop when at 100% duty cycle
     For 100% duty cycle, add 1 to the max counter value
     */
     input [COUNTERBITS:0] dutyCycle,
     input [COUNTERBITS-1:0]counterMax,     //To get this value, use: counterMax = 1/(f_pwm*T_clk)

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
