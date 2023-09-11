`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Donovan Magney
//
// Create Date: 09/05/2023 11:04:24 AM
// Module Name: Channel
// Project Name: MusicalSilicon
// Target Devices:
// Tool Versions: Vivado 2023.1
// Description: A signle audio channel, which outputs a changing PWM signal
//////////////////////////////////////////////////////////////////////////////////


module Channel
  /*
  COUNTERTICKS: The amount of ticks for the PWM counter. To get this value, use: COUNTERTICKS = 1/(f_pwm*T_clk)
  DIVISOR: Divide the clock frequency by this parameter

  F_pwm =  = 1/(T_clk*DIVISOR*COUNTERTICKS)
  */
  #(parameter COUNTERTICKS = 1000, DIVISOR = 1)( //Defaults to 5kHz
     input clk, reset,

     /*
     Duty cycle bit calculation { (dutyCycle% * (2^BITLENGTH)) - 1 = dutyCycle }
     Duty Cycle must be 1 bit larger than the counter to avoid a single cycle drop when at 100% duty cycle
     For 100% duty cycle, add 1 to the max counter value
     */
     input [ $clog2(COUNTERTICKS):0] dutyCycle,

     output PWM,
     output AUD_EN
   );

  //#############################################################
  //Regs & Wires
  //#############################################################

  wire divided_clk;

  //#############################################################
  //Logic
  //#############################################################
  assign AUD_EN = 1;

  CLK_DIV #(DIVISOR) clockDiv(.clk_in(clk), .reset(reset), .clk_out(divided_clk));
  PWM_Generator #(COUNTERTICKS) PWMGen(.clk(divided_clk), .reset(reset), .dutyCycle('d900), .PWM(PWM));

endmodule
