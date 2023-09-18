`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Donovan Magney
//
// Create Date: 09/12/2023 03:04:37 PM
// Module Name: SineChannel
// Project Name: MusicalSilicon
// Target Devices:
// Tool Versions: Vivado 2023.1
// Description: A signle audio channel, which outputs a sine wave
//////////////////////////////////////////////////////////////////////////////////

/*
*****Frequency*****
f_sin = f_clk/(counterMax*DIVISOR*(2^PHASE_BITS))
counterMax = f_clk/(f_sin*DIVISOR*(2^PHASE_BITS))

*****Freq Precision*****
Plug in f_pwm = f_sin = f_clk/(counterMax*DIVISOR*(2^PHASE_BITS)) into a graphing calculator. High freq have lower precision than lower freq

*****Phase*****
0-2PI -> 0-2^N;    
phase_digital = phase_rad((2^N)/(2PI)) where N is the number of bits we are using for representation; N = PHASE_BITS
phase precision = 2PI/(2^PHASE_BITS)
Supply 2^PHASE_BITS worth of data into sine_table.mem

*****Parameters*****
PHASE_BITS: The granularity of the supplied sine wave data. For a total of 2^PHASE_BITS values
    Default: 5; For 32 data points for sine
AMPLITUDE_BITS: The range of integers the amplitude of the sine wave will span, from 0 to 2^AMPLITUDE_BITS
    Default: 8; The amplitude of the sine wave will fall between 0 and 255
COUNTERBITS: The maximum value for the counters
    Defaults: 16; for a max counter value of 65536
DIVISOR: Divide the clock frequency by this parameter
    Default: 1, the clock is passed through and has the highest high freq precision
*/

module SineChannel
    #(parameter PHASE_BITS = 5, AMPLITUDE_BITS = 8, COUNTER_BITS = 16, DIVISOR = 1)(
    input clk, reset,
    
    input [PHASE_BITS - 1:0]phase,
    input [COUNTER_BITS - 1:0]counterMax,
    
    output [AMPLITUDE_BITS - 1:0]sine_out
    );
    
  //#############################################################
  //Regs & Wires
  //#############################################################

  wire divided_clk;
  
  //#############################################################
  //Logic
  //#############################################################
  
    CLK_DIV #(DIVISOR) clockDiv(.clk_in(clk), .reset(reset), .clk_out(divided_clk));
    SineWaveGen #(PHASE_BITS, AMPLITUDE_BITS, COUNTER_BITS) sine_wave(.clk(divided_clk), .reset(reset), .counterMax(counterMax), .sine_out(sine_out), .phase(phase));
    
    
endmodule
