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


//TODO change frequency selection parameters to inputs somehow
//TODO complete TODOs from other files
//TODO Comments -> Fiugre out frequency granularity as freq changes (on analog)
//Input/Output on actual board

module Synthesizer(
    input clk, reset,
    
    //Audio controls
    input [15:0]PWMcounterMax1,
    input [16:0]PWMdutyCycle1,
    
    input [15:0]PWMcounterMax2,
    input [16:0]PWMdutyCycle2,
    
    input [15:0]PWMcounterMax3,
    input [16:0]PWMdutyCycle3,
    
    input [15:0]PWMcounterMax4,
    input [16:0]PWMdutyCycle4,
    
    input [15:0]PWMcounterMax5,
    input [16:0]PWMdutyCycle5,
    
    input [4:0]phase1,
    input [15:0]counterMax1,
    
    input [4:0]phase2,
    input [15:0]counterMax2,
    
    input [4:0]phase3,
    input [15:0]counterMax3,
    
    input [4:0]phase4,
    input [15:0]counterMax4,
    
    input [4:0]phase5,
    input [15:0]counterMax5,
    
    output PWM_OUT,
    output [7:0]SINE_OUT
    );
    
//#############################################################
//Regs & Wires
//#############################################################  

    wire [0:4]pwm_out;
    wire [7:0]sine_out1;
    wire [7:0]sine_out2;
    wire [7:0]sine_out3;
    wire [7:0]sine_out4;
    wire [7:0]sine_out5;

//#############################################################
//Logic
//#############################################################
   
    PWMChannel #(16,1) PWM_Channel1(.clk(clk), .reset(reset), .counterMax(PWMcounterMax1), .dutyCycle(PWMdutyCycle1), .PWM(pwm_out[0]));
    PWMChannel #(16,1) PWM_Channel2(.clk(clk), .reset(reset), .counterMax(PWMcounterMax2), .dutyCycle(PWMdutyCycle2), .PWM(pwm_out[1]));
    PWMChannel #(16,1) PWM_Channel3(.clk(clk), .reset(reset), .counterMax(PWMcounterMax3), .dutyCycle(PWMdutyCycle3), .PWM(pwm_out[2]));
    PWMChannel #(16,1) PWM_Channel4(.clk(clk), .reset(reset), .counterMax(PWMcounterMax4), .dutyCycle(PWMdutyCycle4), .PWM(pwm_out[3]));
    PWMChannel #(16,1) PWM_Channel5(.clk(clk), .reset(reset), .counterMax(PWMcounterMax5), .dutyCycle(PWMdutyCycle5), .PWM(pwm_out[4]));
    
    SineChannel #(5,10,16,2) sine_wave1(.clk(clk), .reset(reset), .phase(phase1), .counterMax(counterMax1), .sine_out(sine_out1));
    SineChannel #(5,10,16,2) sine_wave2(.clk(clk), .reset(reset), .phase(phase2), .counterMax(counterMax2), .sine_out(sine_out2));
    SineChannel #(5,10,16,2) sine_wave3(.clk(clk), .reset(reset), .phase(phase3), .counterMax(counterMax3), .sine_out(sine_out3));
    SineChannel #(5,10,16,2) sine_wave4(.clk(clk), .reset(reset), .phase(phase4), .counterMax(counterMax4), .sine_out(sine_out4));
    SineChannel #(5,10,16,2) sine_wave5(.clk(clk), .reset(reset), .phase(phase5), .counterMax(counterMax5), .sine_out(sine_out5));
    
    //Output
    assign PWM_OUT = |pwm_out;  
    assign SINE_OUT = (sine_out1 + sine_out2 + sine_out3 + sine_out4 + sine_out5)/5;
    
endmodule
