`timescale 1ns / 1ps


module SinWaveGen_TB();

//1) Declare local reg and wire identifiers (use reg for inputs and wires for output of the UUT)
//2) Instantiate the unit under test (UUT)
//3) Specify a stopwatch to stop the simulation
//4) Generate stimuli, using initial and always

reg clk, reset;
wire [7:0]sine_out;

SineWaveGen sine_wave(.clk(clk), .reset(reset), .sine_out(sine_out));

//Sim Setup
initial
begin
    #4100 $finish;
end

//Clk
initial clk = 'b0;
always #5 clk = ~clk;

initial
begin
    reset = 0;
    #10
    reset = 1;
    #64
    reset = 0;
    #10
    reset = 1;
end

endmodule
