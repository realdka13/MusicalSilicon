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
    #(parameter BITLENGTH = 8, DIVISOR = 2)(
    input clk, reset,
    
    /*
    Duty cycle bit calculation { (dutyCycle% * (2^BITLENGTH)) - 1 = dutyCycle }
    Duty Cycle must be 1 bit larger than the counter to avoid a single cycle drop when at 100% duty cycle
    */
    input [BITLENGTH:0]dutyCycle,
    output PWM
    );

//#############################################################
//Regs & Wires
//#############################################################  

    wire divided_clk;

//#############################################################
//Logic
//#############################################################

    //CLK_DIV #(DIVISOR) clockDiv(.clk_in(clk), .reset(reset), .clk_out(divided_clk));
    //PWM_Generator #(BITLENGTH) PWMGen(.clk(clk), .reset(reset), .dutyCycle(dutyCycle), .PWM(PWM));
    
endmodule