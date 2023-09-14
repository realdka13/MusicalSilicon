`timescale 1us / 1ns

//1) Declare local reg and wire identifiers (use reg for inputs and wires for output of the UUT)
//2) Instantiate the unit under test (UUT)
//3) Specify a stopwatch to stop the simulation
//4) Generate stimuli, using initial and always

module PWMGen_TB();

reg clk;
reg reset;
reg [31:0]dutyCycle;
reg [15:0]counterMax;

wire PWM;
integer i;
integer bool;

PWM_Generator #(16) UUT(.clk(clk), .reset(reset), .counterMax(counterMax), .dutyCycle(dutyCycle), .PWM(PWM));

//Clk
initial clk = 'b0;
always #0.005 clk = ~clk;

//Test
initial
begin
    bool = 1;
    reset = 'b1;
    counterMax = 'd100;
    dutyCycle = 'd25;
    
    
    #0.0010
    reset = 'b0;
    #0.0010
    reset = 'b1;
    
    //Basic
    ///*
    #25
    dutyCycle = 'd50;
    #25
    dutyCycle = 'd75;
    #25
    dutyCycle = 'd101;
    //*/
    
    //Oscillations
    /*
    for(i = 0; i <= 80; i = i + 1)
    begin
        #10
        if(bool)
        begin
            if(dutyCycle >= 900)
                bool = 0;       
            else     
                dutyCycle = dutyCycle + 10;
        end
        else if(~bool)
        begin
            if(dutyCycle <= 500)
                bool = 1;     
            else     
                dutyCycle = dutyCycle - 10;
        end
    end
    */
end

endmodule
