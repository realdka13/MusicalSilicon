`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Donovan Magney
// 
// Create Date: 09/05/2023 11:01:43 AM
// Module Name: Synthesizer
// Project Name: MusicalSilicon
// Target Devices: 
// Tool Versions: Vivado 2023.1
// Description: Generates changing PWM and sine signals
//////////////////////////////////////////////////////////////////////////////////

//TODO Rename PHASE_BITS
//TODO change frequency selection parameters to inputs somehow
//TODO complete TODOs from other files
//TODO Comments -> Fiugre out frequency granularity as freq changes (on analog)
//Input/Output on actual board

module Synthesizer
    #(parameter ANALOG_CHANNELS = 5, PWM_CHANNELS = 6)(
    input clk, reset,
    
    //Audio controls
    //[:]phase;
    
    output PWM_OUT,
    output [7:0]SINE_OUT
    );
    
//#############################################################
//Regs & Wires
//#############################################################  

    wire [0:PWM_CHANNELS - 1]pwm_out;
    wire [7:0] sine_out [0:ANALOG_CHANNELS - 1];
    
    genvar i;

//#############################################################
//Logic
//#############################################################

    generate
    
    for(i = 0; i < PWM_CHANNELS; i = i + 1)
    begin
        PWMChannel #() PWM_Channel(.clk(clk), .reset(reset), .dutyCycle(), .PWM(pwm_out[i]));
    end
    
    for(i = 0; i < ANALOG_CHANNELS; i = i + 1)
    begin
        SineChannel #() sine_wave(.clk(clk), .reset(reset), .phase(0), .sine_out(sine_out[i]));
    end
    
    endgenerate
    
    //Output
    assign PWM_OUT = |pwm_out;  
    //assign SINE_OUT = SINE_OUT + sine_out[i]; //This work?
    
endmodule
