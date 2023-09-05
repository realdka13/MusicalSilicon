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


module PWM_Generator
    #(parameter BITLENGTH = 8)(
    input clk,
    input reset,
    
    /*
    Duty cycle bit calculation { (dutyCycle% * (2^BITLENGTH)) - 1 = dutyCycle }
    Duty Cycle must be 1 bit larger than the counter to avoid a single cycle drop when at 100% duty cycle
    */
    input [BITLENGTH:0] dutyCycle,
    
    //Single Bit Output
    output reg PWM   //PWM is a reg to avoid glitches
    );

//#############################################################
//Regs & Wires
//#############################################################  
    
    //Counter
    reg [BITLENGTH - 1:0] counter, counter_Next;
    
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
        counter_Next <= counter + 1;
        
    //Counter Output
    always@(posedge clk, negedge reset)
    begin
        if(~reset)
            PWM <= 0;
        else
            PWM <= (counter < dutyCycle);
    end
            
endmodule
