`timescale 1ns / 1ps

//1) Declare local reg and wire identifiers (use reg for inputs and wires for output of the UUT)
//2) Instantiate the unit under test (UUT)
//3) Specify a stopwatch to stop the simulation
//4) Generate stimuli, using initial and always

module CLK_DIV_TB();

reg clk, reset;
wire clk_out;

CLK_DIV #(10) UUT(.clk_in(clk), .reset(reset), .clk_out(clk_out));

//Sim Setup
initial
begin
    #100 $finish;
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
end

endmodule
