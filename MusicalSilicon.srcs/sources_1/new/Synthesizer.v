`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Donovan Magney
// 
// Create Date: 09/05/2023 11:01:43 AM
// Module Name: Synthesizer
// Project Name: MusicalSilicon
// Target Devices: 
// Tool Versions: Vivado 2023.1
// Description: Generates changing PWM signals
//////////////////////////////////////////////////////////////////////////////////


module Synthesizer
    #(parameter Channels = 1)(
    input clk, reset
    
    input [Channels - 1:0]
    
    output[Channels - 1:0] PWM
    );
    
//#############################################################
//Regs & Wires
//#############################################################  

    genvar i;

//#############################################################
//Logic
//#############################################################
 
    Channel #(2000,10) Channels(.clk(clk), .reset(reset), .dutyCycle(), .PWM(PWM[i]));
    
endmodule
