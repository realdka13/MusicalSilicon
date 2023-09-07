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
    /*
    COUNTERTICKS: The amount of ticks for the counter. To get this value, use: COUNTERTICKS = 1/(f_pwm*T_clk)
    F_pwm = 1/(COUNTERTICKS*T_clk)
    */
    #(parameter COUNTERTICKS = 1000)(
    input clk,
    input reset,
    
    /*
    Duty cycle bit calculation { (dutyCycle% * (2^BITLENGTH)) - 1 = dutyCycle }
    Duty Cycle must be 1 bit larger than the counter to avoid a single cycle drop when at 100% duty cycle
    For 100% duty cycle, add 1 to the max counter value
    */
    input [ $clog2(COUNTERTICKS):0] dutyCycle,
    
    //Single Bit Output
    output reg PWM   //PWM is a reg to avoid glitches
    );

//#############################################################
//Regs & Wires
//#############################################################  
    
    //Counter
    reg [ $clog2(COUNTERTICKS) - 1:0] counter, counter_Next;
    
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
        else if(counter_Next >= COUNTERTICKS)
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
