`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Donovan Magney
// 
// Create Date: 09/04/2023 12:07:33 PM
// Module Name: PWM_Generator
// Project Name: MusicalSilicon
// Target Devices: 
// Tool Versions: Vivado 2023.1
// Description: Takes in a clock, and a duty cycle value and returns a PWM output
//////////////////////////////////////////////////////////////////////////////////

/*
*****Frequency*****
counterMax = f_clk/f_pwm
f_pwm = f_clk/counterMax

*****Freq Precision*****
Plug in f_pwm = f_clk/counterMax into a graphing calculator. High freq have lower precision than lower freq

*****Duty Cycle*****
The duty cycle is the counter value at which the output switches from high to low
Duty Cycle must be 1 bit larger than counterMax to avoid a single clk cycle drop when at 100% duty cycle
For 100% duty cycle, add 1 to the max counter value

*****Parameters*****
COUNTEBITS: The amount of bits required for the counter.
    Default: 16, for a max value of 65536
*/

module PWM_Generator
    #(parameter COUNTERBITS = 16)(
    input clk, reset,
    
    input [COUNTERBITS-1:0]counterMax,
    input [COUNTERBITS:0] dutyCycle,
    
    //Single Bit Output
    output reg PWM   //PWM is a reg to avoid glitches
    );

//#############################################################
//Regs & Wires
//#############################################################  
    
    //Counter
    reg [COUNTERBITS:0] counter, counter_Next;
    
//#############################################################
//Logic
//#############################################################
     
    //Counter Logic
    always @(posedge clk, negedge reset)
    begin
        if(~reset)
            counter <= 0;
        else
            counter <= counter_Next;
    end
    
    //Counter Next Logic
    always @(posedge clk, negedge reset)
    begin
        if(~reset)
            counter_Next <= 1;
        else if(counter_Next >= counterMax)
            counter_Next <= 0;
        else
            counter_Next <= counter_Next + 1;
    end
     
    //Counter Output
    always@(*)
    begin
        if(~reset)
            PWM <= 0;
        else
            PWM <= (counter < dutyCycle);
    end
            
endmodule
