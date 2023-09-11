`timescale 1us / 1ns

//1) Declare local reg and wire identifiers (use reg for inputs and wires for output of the UUT)
//2) Instantiate the unit under test (UUT)
//3) Specify a stopwatch to stop the simulation
//4) Generate stimuli, using initial and always

module Channel_TB();

reg clk;
reg reset;
reg [10:0]dutyCycle;
wire PWM;
integer i;
integer bool;

Channel #(1000,100) UUT(.clk(clk), .reset(reset), .dutyCycle(dutyCycle), .PWM(PWM));

//Sim Setup
initial
begin
    #4100 $finish;
end

//Clk
initial clk = 'b0;
always #0.005 clk = ~clk;

//Test

initial
begin
    bool = 1;
    reset = 'b1;
    dutyCycle = 'd250;
    
    
    #0.0010
    reset = 'b0;
    #0.0010
    reset = 'b1;
    
    //Basic
    ///*
    #1000
    dutyCycle = 'd500;
    #1000
    dutyCycle = 'd750;
    #1000
    dutyCycle = 'd1001;
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
