`timescale 1ns / 1ps



module SineChannel_TB();

//1) Declare local reg and wire identifiers (use reg for inputs and wires for output of the UUT)
//2) Instantiate the unit under test (UUT)
//3) Specify a stopwatch to stop the simulation
//4) Generate stimuli, using initial and always

reg clk, reset;
//reg [4:0]phase;

wire [7:0]sine_out1;
wire [7:0]sine_out2;
wire [7:0]sine_out3;
wire [7:0]sine_out4;

SineChannel #(5, 10, 16) sine_wave1(.clk(clk), .reset(reset), .counterMax('d1000), .sine_out(sine_out1), .phase(0));
SineChannel #(5, 10, 16) sine_wave2(.clk(clk), .reset(reset), .counterMax('d5000), .sine_out(sine_out2), .phase(8));
SineChannel #(5, 10, 16) sine_wave3(.clk(clk), .reset(reset), .counterMax('d10000), .sine_out(sine_out3), .phase(16));
SineChannel #(5, 10, 16) sine_wave4(.clk(clk), .reset(reset), .counterMax('d15000), .sine_out(sine_out4), .phase(24));


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
