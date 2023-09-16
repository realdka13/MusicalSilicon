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
*****Phase*****
0-2PI -> 0-2^N;    
phase_digital = phase_rad((2^N)/(2PI)) where N is the number of bits we are using for representation; N = PHASE_BITS
phase precision = 2PI/(2^PHASE_BITS)
PHASE_BITS <= 32
Supply 2^PHASE_BITS worth of data into sine_table.mem

*****Frequency*****
frequency_hz = 1/((2^N) * 1/clk_freq_hz)    -> Modify the input clock to change the frequency
clk_freq_hz = frequency_hz * (2^N)
frequency_precision_hz = clock_freq_hz / 2^PHASE_BITS
*/

module SineChannel
    #(parameter PHASE_BITS = 5, AMPLITUDE_BITS = 10, COUNTER_BITS = 16, DIVISOR = 2)(
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
