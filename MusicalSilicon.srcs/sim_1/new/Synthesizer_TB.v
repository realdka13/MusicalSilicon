`timescale 1ns / 1ps


module Synthesizer_TB();

//1) Declare local reg and wire identifiers (use reg for inputs and wires for output of the UUT)
//2) Instantiate the unit under test (UUT)
//3) Specify a stopwatch to stop the simulation
//4) Generate stimuli, using initial and always

reg clk, reset;

wire PWM_OUT;
wire [7:0]SINE_OUT;

Synthesizer UUT(.clk(clk), .reset(reset),
 .PWMcounterMax1('d1000), .PWMdutyCycle1('d500), 
 .PWMcounterMax2('d5000), .PWMdutyCycle2('d2500),
 .PWMcounterMax3('d10000), .PWMdutyCycle3('d5000),
 .PWMcounterMax4('d15000), .PWMdutyCycle4('d7500),
 .PWMcounterMax5('d20000), .PWMdutyCycle5('d10000),
 
 
 .PWM_OUT(PWM_OUT), .SINE_OUT(SINE_OUT));

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
