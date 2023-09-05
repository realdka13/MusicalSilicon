`timescale 1ns / 1ps

//1) Declare local reg and wire identifiers (use reg for inputs and wires for output of the UUT)
//2) Instantiate the unit under test (UUT)
//3) Specify a stopwatch to stop the simulation
//4) Generate stimuli, using initial and always

module PWMGen_TB();

reg clk;
reg reset;
reg [8:0]dutyCycle;
wire PWM;

PWM_Generator UUT(.clk(clk), .reset(reset), .dutyCycle(dutyCycle), .PWM(PWM));

//Sim Setup
initial
begin
    #40000 $finish;
end

//Clk
initial clk = 1'b0;
always #1 clk = ~clk;

//Test
initial
begin
    reset = 1'b0;
    #5
    reset = 1'b1;
    
    dutyCycle = 9'd63;
    #10000
    dutyCycle = 9'd127;
    #10000
    dutyCycle = 9'd191;
    #10000
    dutyCycle = 9'd256;
end

endmodule
