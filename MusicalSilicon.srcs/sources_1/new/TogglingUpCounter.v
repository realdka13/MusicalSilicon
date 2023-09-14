`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Donovan Magney
//
// Create Date: 09/14/2023 03:19:38 PM
// Module Name: TogglingUpCounter
// Project Name: MusicalSilicon
// Target Devices:
// Tool Versions: Vivado 2023.1
// Description:  Up Counter with a maximum value, and toggling output
//////////////////////////////////////////////////////////////////////////////////


module TogglingUpCounter
    #(parameter COUNTER_BITS = 8)(
    input clk,
    input reset,
    input [COUNTER_BITS - 1:0]counterMax,
    
    output reg Q
    );
    
    //#############################################################
    //Regs & Wires
    //#############################################################
    
    reg [COUNTER_BITS - 1:0] counter, counterNext;
    
    //#############################################################
    //Logic
    //#############################################################
    
    //Counter
    always@(posedge clk, negedge reset)
    begin
    
    end
    
    //Counter Next
    always@(posedge clk, negedge reset)
    begin
    
    end
    
    
    //Output
    always@(posedge clk, negedge reset)
    begin
    
    end
    
endmodule
