`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Donovan Magney
//
// Create Date: 09/10/2023 07:22:48 PM
// Module Name: Channel
// Project Name: MusicalSilicon
// Target Devices:
// Tool Versions: Vivado 2023.1
// Description: Generates a digital sine wave based off of a LUT
//////////////////////////////////////////////////////////////////////////////////


//TODO better phase implementation
//TODO show math equations as in zipcpu
//TODO input a frequency

module SineWaveGen(
    input clk, reset,
    
    output reg [7:0]sine_out    //TODO Bitlength
    );
    
    
  //#############################################################
  //Regs & Wires
  //#############################################################
  
  //32 byes of ROM
  reg [7:0] sine [0:31];    //TODO change sine bytes to param, TODO play with bit length
  
  //To keep track of current phase
  integer i;
  
  //#############################################################
  //Fill ROM    //TODO change to memory file    // TODO Change to quarter table
  //#############################################################
  
  initial begin
    sine[0] = 0;
    sine[1] = 15;
    sine[2] = 30;
    sine[3] = 43;
    sine[4] = 55;
    sine[5] = 65;
    sine[6] = 72;
    sine[7] = 77;
    sine[8] = 78;
    sine[9] = 77;
    sine[10] = 72;
    sine[11] = 65;
    sine[12] = 55;
    sine[13] = 43;
    sine[14] = 30;
    sine[15] = 15;
    sine[16] = 0;
    sine[17] = -15;
    sine[18] = -30;
    sine[19] = -43;
    sine[20] = -55;
    sine[21] = -65;
    sine[22] = -72;
    sine[23] = -77;
    sine[24] = -78;
    sine[25] = -77;
    sine[26] = -72;
    sine[27] = -65;
    sine[28] = -55;
    sine[29] = -43;
    sine[30] = -30;
    sine[31] = -15;
  end
  
  //#############################################################
  //Logic
  //#############################################################
  
  always@(posedge clk)
  begin
    if(~reset)
    begin
        i <= 0;
        sine_out <= 0;
    end
    else
    begin
        sine_out <= sine[i];
        if(i == 31)
            i <= 0;
        else
            i = i + 1;
    end
  end
  
endmodule
