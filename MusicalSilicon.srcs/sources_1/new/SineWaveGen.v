`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Donovan Magney
//
// Create Date: 09/10/2023 07:22:48 PM
// Module Name: SineWaveGen
// Project Name: MusicalSilicon
// Target Devices:
// Tool Versions: Vivado 2023.1
// Description: Generates a digital sine wave based off of a LUT
//////////////////////////////////////////////////////////////////////////////////


//TODO Change to quarter table for the sine wave


/*
*****Frequency*****
f_sin = f_clk/(counterMax*(2^PHASE_BITS))
counterMax = f_clk/(f_sin*(2^PHASE_BITS))

*****Freq Precision*****
Plug in f_pwm = f_sin = f_clk/(counterMax*(2^PHASE_BITS)) into a graphing calculator. High freq have lower precision than lower freq

*****Phase*****
0-2PI -> 0-2^N;    
phase_digital = phase_rad((2^N)/(2PI)) where N is the number of bits we are using for representation; N = PHASE_BITS

phase precision = 2PI/(2^PHASE_BITS)

Supply 2^PHASE_BITS worth of data into sine_table.mem

*****Amplitude*****

*****Parameters*****
PHASE_BITS: The granularity of the supplied sine wave data. For a total of 2^PHASE_BITS values
    Default: 5; For 32 data points for sine
AMPLITUDE_BITS: The range of integers the amplitude of the sine wave will span, from 0 to 2^AMPLITUDE_BITS
    Default: 8; The amplitude of the sine wave will fall between 0 and 255
COUNTERBITS: The maximum value for the counters
    Defaults: 16; for a max counter value of 65536
*/

module SineWaveGen
    #(parameter PHASE_BITS = 5, AMPLITUDE_BITS = 8, COUNTERBITS = 16)(
    input clk, reset,
    
    input [COUNTERBITS - 1:0]counterMax,
    input [PHASE_BITS - 1:0]phase,
    
    output reg [AMPLITUDE_BITS - 1:0]sine_out
    );
    
    //#############################################################
    //Regs & Wires
    //#############################################################
  
    //32 byes of ROM
    reg [AMPLITUDE_BITS - 1:0] sine [0:2**PHASE_BITS - 1];  //Need sine values for every possible phase value
    
    //Counter
    reg [COUNTERBITS - 1:0]counter, counterNext;
    reg counterClk;
    
    //To keep track of current phase
    integer i;
  
    //#############################################################
    //Read from MEM
    //#############################################################

    //ROM
    initial $readmemh("C:/Users/donov/Desktop/DonovanMPersonalFiles/_GitStored/FPGA/MusicalSilicon/MusicalSilicon/MusicalSilicon.srcs/sources_1/new/sine_table.mem", sine);

  //#############################################################
  //Logic
  //#############################################################
  
  //Freq counter
  always@(posedge clk, negedge reset)
  begin
    if(~reset)
        counter <= 0;
    else
        counter <= counterNext;
  end
  
  //Freq counter Next
  always@(posedge clk, negedge reset)
  begin
      if(~reset)
        counterNext <= 1;
      else if(counterNext >= counterMax)
        counterNext <= 0;
      else
        counterNext <= counterNext + 1;
  end
  
  //Counter output
  always @(posedge clk, negedge reset)
  begin
    if(~reset)
        counterClk <= 0;
    else if(counter == counterMax)
        counterClk <= ~counterClk;
  end
  
  //Sine Wave Generator -> i is the index into the sine wave data
    always@(posedge counterClk, negedge counterClk, negedge reset)
    begin
        if(~reset)
        begin
            i <= phase;
            sine_out <= sine[i];
        end
    else
    begin
        sine_out <= sine[i];
        if(i == 2**PHASE_BITS - 1)
            i <= 0;
        else
            i = i + 1;
    end
    end
  
endmodule
