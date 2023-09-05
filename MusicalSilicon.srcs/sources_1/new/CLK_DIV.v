`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Donovan Magney
// 
// Create Date: 09/05/2023 10:30:08 AM
// Module Name: CLK_DIV
// Project Name: MusicalSilicon
// Target Devices: 
// Tool Versions: Vivado 2023.1
// Description: Divides the clock
//////////////////////////////////////////////////////////////////////////////////


module CLK_DIV
    #(parameter DIVISOR = 2)(
    input clk_in,
    input reset,
    output reg clk_out
    );
    
//#############################################################
//Regs & Wires & Parameters
//#############################################################  

    reg [$clog2(DIVISOR)-1:0]counter;

//#############################################################
//Logic
//############################################################# 

    //Counter
    always @(posedge clk_in, negedge reset)
    begin
        if(~reset)
            counter <= 0;
        else if(counter >= (DIVISOR-1))
            counter <= 28'd0;
        else
            counter <= counter + 1;
    end
    
    //Output
    always @(posedge clk_in, negedge reset)
    begin
        if(~reset)
            clk_out <= 0;
        else
            clk_out <= (counter < DIVISOR/2) ? 1'b1:1'b0;
    end
    
endmodule  
