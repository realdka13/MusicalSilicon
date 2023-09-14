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


//TODO Change to quarter table


/*
*****Phase*****
0-2PI -> 0-2^N;    
phase_digital = phase_rad((2^N)/(2PI)) where N is the number of bits we are using for representation; N = PHASE_BITS
phase precision = 2PI/(2^PHASE_BITS)
PHASE_BITS <= 32
Supply 2^PHASE_BITS worth of data into sine_table.mem

*****Frequency*****
frequency_hz = 1/((2^N) * 1/clk_freq_hz)    -> Modify the input clock to change the frequency
clk_freq_hz = frequency_hz * (2^N)
frequency_precision_hz = clock_freq_hz / 2^PHASE_BITS

*****Amplitude*****

*/

module SineWaveGen
    #(parameter PHASE_BITS = 5, AMPLITUDE_BITS = 10)(
    input clk, reset,
    
    input [PHASE_BITS - 1:0]phase,
    
    output reg [AMPLITUDE_BITS - 1:0]sine_out
    );
    
    //#############################################################
    //Regs & Wires
    //#############################################################
  
    //32 byes of ROM
    reg [AMPLITUDE_BITS - 1:0] sine [0:2**PHASE_BITS - 1];  //Need sine values for every possible phase value
  
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
  
    always@(posedge clk, negedge reset)
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
