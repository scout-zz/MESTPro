`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2023 02:10:30 PM
// Design Name: 
// Module Name: MestPro_STIM_V2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MestPro_STIM_V2
(
  //output ports
  output reg [7:0] IN_DATA,
  output reg [7:0] INSTRUCTION,
  output reg CLK,
  output reg RESET, 
  
  //input ports
  input wire [7:0] OUT_DATA

);

// initial block contains all: 
// 1- initialization for RESET and CLK
// 2- all the stimulation to the processor inputs
initial 
begin 
// initialization for RESET and CLK
RESET = 1'b0 ;
CLK = 1'b0 ;

//remove RESET after 100 ns
#100 
RESET = 1'b1 ;

// Set up Monitor 
$monitor( "time=%3d, RESET=%d, INSTRUCTION=%d, IN_DATA=%d, OUT_DATA=%d", $time, RESET,
    INSTRUCTION, IN_DATA, OUT_DATA );

// input stimulation
// program for out = 5 +3 

/******************************************************************************
Add Tests
******************************************************************************/
// Test Case: Add.1.1 Simple Addition /////////////////////////////////////////
$display( "Test Case: Add.1.1: 5+3 = 8" );
IN_DATA = 8'd5 ; 
INSTRUCTION = 8'd1; //loading A register by 5
#100
INSTRUCTION = 8'd2 ; //loading the first value to ACC
#100
INSTRUCTION = 8'd7 ; //Display the loaded value on the output port
#100
IN_DATA = 8'd3 ; 
INSTRUCTION = 8'd1; //loading A register by 3
#100
INSTRUCTION = 8'd2 ; //adding to ACC
#100
INSTRUCTION = 8'd7 ; //Display the result on the output port
#100
$display( "Test Complete: OUT_DATA= %d expected %d", OUT_DATA, 8);

// Reset ALU //////////////////////////////////////////////////////////////////
$display( "ALU RESET" );
#100
RESET = 1'b0;
#100
RESET = 1'b1;
#100

// Test Case Add.1.2 Identity /////////////////////////////////////////////////
$display( "Test Case: Add.1.2: 14 + 0 = 14" );
IN_DATA = 8'd14 ; 
INSTRUCTION = 8'd1; //loading A register by 14
#100
INSTRUCTION = 8'd2 ; //loading the first value to ACC
#100
INSTRUCTION = 8'd7 ; //Display the loaded value on the output port
#100
IN_DATA = 8'd0; 
INSTRUCTION = 8'd1; //loading A register by 0
#100
INSTRUCTION = 8'd2 ; //adding to ACC
#100
INSTRUCTION = 8'd7 ; //Display the result on the output port 
#100
$display( "Test Complete: OUT_DATA= %d expected %d", OUT_DATA, 14);

// Reset ALU //////////////////////////////////////////////////////////////////
$display( "ALU RESET" );
#100
RESET = 1'b0;
#100
RESET = 1'b1;
#100

// Test Case Add.1.3 Overflow  ////////////////////////////////////////////////
$display( "Test Case: Add.1.3: 255 + 2 = 1" );
IN_DATA = 8'd255 ; 
INSTRUCTION = 8'd1; //loading A register by 255
#100
INSTRUCTION = 8'd2 ; //loading the first value to ACC
#100
INSTRUCTION = 8'd7 ; //Display the loaded value on the output port
#100
IN_DATA = 8'd2; 
INSTRUCTION = 8'd1; //loading A register by 2
#100
INSTRUCTION = 8'd2 ; //adding to ACC
#100
INSTRUCTION = 8'd7 ; //Display the result on the output port
#100
$display( "Test Complete: OUT_DATA= %d expected %d", OUT_DATA, 1);

/******************************************************************************
Sub Tests
******************************************************************************/
// Reset ALU //////////////////////////////////////////////////////////////////
$display( "ALU RESET" );
#100
RESET = 1'b0;
#100
RESET = 1'b1;
#100

// Test Case Sub.1.1: Simple Subtraction  /////////////////////////////////////
$display( "Test Case: Sub.1.1: 10 - 8" );
IN_DATA = 8'd10 ; 
INSTRUCTION = 8'd1; //loading A register by 10
#100
INSTRUCTION = 8'd2 ; //loading the first value to ACC
#100
INSTRUCTION = 8'd7 ; //Display the loaded value on the output port
#100
IN_DATA = 8'd8; 
INSTRUCTION = 8'd1; //loading A register by 8
#100
INSTRUCTION = 8'd3 ; //Subtracting from ACC
#100
INSTRUCTION = 8'd7 ; //Display the result on the output port
#100
$display( "Test Complete: OUT_DATA= %d expected %d", OUT_DATA, 2);

// Reset ALU //////////////////////////////////////////////////////////////////
$display( "ALU RESET" );
#100
RESET = 1'b0;
#100
RESET = 1'b1;
#100

// Test Case Sub.1.2 Identity  ////////////////////////////////////////////////
$display( "Test Case: Sub.1.2: 45 - 0" );
IN_DATA = 8'd45 ; 
INSTRUCTION = 8'd1; //loading A register by 45
#100
INSTRUCTION = 8'd2 ; //loading the first value to ACC
#100
INSTRUCTION = 8'd7 ; //Display the loaded value on the output port
#100
IN_DATA = 8'd0; 
INSTRUCTION = 8'd1; //loading A register by 0
#100
INSTRUCTION = 8'd3 ; //Subtracting from ACC
#100
INSTRUCTION = 8'd7 ; //Display the result on the output port
#100
$display( "Test Complete: OUT_DATA= %d expected %d", OUT_DATA, 45);

// Reset ALU //////////////////////////////////////////////////////////////////
$display( "ALU RESET" );
#100
RESET = 1'b0;
#100
RESET = 1'b1;
#100

// Test Case Sub.1.3 Zero  ////////////////////////////////////////////////////
$display( "Test Case: Sub.1.3: 37 - 37" );
IN_DATA = 8'd37; 
INSTRUCTION = 8'd1; //loading A register by 37
#100
INSTRUCTION = 8'd2 ; //loading the first value to ACC
#100
INSTRUCTION = 8'd7 ; //Display the loaded value on the output port
#100
IN_DATA = 8'd37; 
INSTRUCTION = 8'd1; //loading A register by 37
#100
INSTRUCTION = 8'd3 ; //Subtracting from ACC
#100
INSTRUCTION = 8'd7 ; //Display the result on the output port
#100
$display( "Test Complete: OUT_DATA= %d expected %d", OUT_DATA, 0);

// Reset ALU //////////////////////////////////////////////////////////////////
$display( "ALU RESET" );
#100
RESET = 1'b0;
#100
RESET = 1'b1;
#100

// Test Case Sub.1.4 Underflow  ///////////////////////////////////////////////
$display( "Test Case: Sub.1.4: 29 - 33" );
IN_DATA = 8'd29 ; 
INSTRUCTION = 8'd1; //loading A register by 37
#100
INSTRUCTION = 8'd2 ; //loading the first value to ACC
#100
INSTRUCTION = 8'd7 ; //Display the loaded value on the output port
#100
IN_DATA = 8'd33; 
INSTRUCTION = 8'd1; //loading A register by 33
#100
INSTRUCTION = 8'd3 ; //Subtracting from ACC
#100
INSTRUCTION = 8'd7 ; //Display the result on the output port
#100
$display( "Test Complete: OUT_DATA= %d expected %d", OUT_DATA, 252 );

/******************************************************************************
And Tests
******************************************************************************/
// Reset ALU //////////////////////////////////////////////////////////////////
$display( "ALU RESET" );
#100
RESET = 1'b0;
#100
RESET = 1'b1;
#100

// Test Case And.1.1 Simple And - False ///////////////////////////////////////
$display( "Test Case: And.1.1: Simple And - False");
IN_DATA = 8'b11110000 ; 
INSTRUCTION = 8'd1; //loading A register by 11110000
#100
INSTRUCTION = 8'd2 ; //loading the first value to ACC
#100
INSTRUCTION = 8'd7 ; //Display the loaded value on the output port
#100
IN_DATA = 8'b00001111; 
INSTRUCTION = 8'd1; //loading A register by 00001111
#100
INSTRUCTION = 8'd4 ; //Anding with ACC
#100
INSTRUCTION = 8'd7 ; //Display the result on the output port 
#100
$display( "Test Complete: OUT_DATA= %b expected %b", OUT_DATA, 8'b00000000);

// Reset ALU //////////////////////////////////////////////////////////////////
$display( "ALU RESET" );
#100
RESET = 1'b0;
#100
RESET = 1'b1;
#100

// Test Case And.1.2 Simple And - True ////////////////////////////////////////
$display( "Test Case: And.1.2: Simple And - True");
IN_DATA = 8'b10101010 ; 
INSTRUCTION = 8'd1; //loading A register by 10101010
#100
INSTRUCTION = 8'd2 ; //loading the first value to ACC
#100
INSTRUCTION = 8'd7 ; //Display the loaded value on the output port
#100
IN_DATA = 8'b10101010; 
INSTRUCTION = 8'd1; //loading A register by 10101010
#100
INSTRUCTION = 8'd4 ; //Anding with ACC
#100
INSTRUCTION = 8'd7 ; //Display the result on the output port
#100
$display( "Test Complete: OUT_DATA= %b expected %b", OUT_DATA, 8'b10101010);

/******************************************************************************
Or Tests
******************************************************************************/
// Reset ALU //////////////////////////////////////////////////////////////////
$display( "ALU RESET" );
#100
RESET = 1'b0;
#100
RESET = 1'b1;
#100

// Test Case Or.1.1 Simple Or - False ///////////////////////////////////////
$display( "Test Case: Or.1.1: Simple Or - False");
IN_DATA = 8'b00000000; 
INSTRUCTION = 8'd1; //loading A register by 00000000
#100
INSTRUCTION = 8'd2 ; //loading the first value to ACC
#100
INSTRUCTION = 8'd7 ; //Display the loaded value on the output port
#100
IN_DATA = 8'b00000000; 
INSTRUCTION = 8'd1; //loading A register by 00000000
#100
INSTRUCTION = 8'd5 ; //oring with ACC
#100
INSTRUCTION = 8'd7 ; //Display the result on the output port 
#100
$display( "Test Complete: OUT_DATA= %b expected %b", OUT_DATA, 8'b00000000);

// Reset ALU //////////////////////////////////////////////////////////////////
$display( "ALU RESET" );
#100
RESET = 1'b0;
#100
RESET = 1'b1;
#100

// Test Case Or.1.2 Simple Or - True ////////////////////////////////////////
$display( "Test Case: Or.1.2: Simple Or - True");
IN_DATA = 8'b10101010; 
INSTRUCTION = 8'd1; //loading A register by 10101010
#100
INSTRUCTION = 8'd2 ; //loading the first value to ACC
#100
INSTRUCTION = 8'd7 ; //Display the loaded value on the output port
#100
IN_DATA = 8'b01010101; 
INSTRUCTION = 8'd1; //loading A register by 01010101
#100
INSTRUCTION = 8'd5 ; //oring with ACC
#100
INSTRUCTION = 8'd7 ; //Display the result on the output port 
#100
$display( "Test Complete: OUT_DATA= %b expected %b", OUT_DATA, 8'b11111111);

/******************************************************************************
XOr Tests
******************************************************************************/
// Reset ALU //////////////////////////////////////////////////////////////////
$display( "ALU RESET" );
#100
RESET = 1'b0;
#100
RESET = 1'b1;
#100

// Test Case XOr.1.1 Simple XOr - False ///////////////////////////////////////
$display( "Test Case: XOr.1.1: Simple XOr - False");
IN_DATA = 8'b10101010; 
INSTRUCTION = 8'd1; //loading A register by 10101010
#100
INSTRUCTION = 8'd2 ; //loading the first value to ACC
#100
INSTRUCTION = 8'd7 ; //Display the loaded value on the output port
#100
IN_DATA = 8'b10101010; 
INSTRUCTION = 8'd1; //loading A register by 10101010
#100
INSTRUCTION = 8'd6 ; //xoring with ACC
#100
INSTRUCTION = 8'd7 ; //Display the result on the output port 
#100
$display( "Test Complete: OUT_DATA= %b expected %b", OUT_DATA, 8'b00000000);

// Reset ALU //////////////////////////////////////////////////////////////////
$display( "ALU RESET" );
#100
RESET = 1'b0;
#100
RESET = 1'b1;
#100

// Test Case XOr.1.2 Simple XOr - True ////////////////////////////////////////
$display( "Test Case: XOr.1.2: Simple XOr - True");
IN_DATA = 8'b10101010; 
INSTRUCTION = 8'd1; //loading A register by 10101010
#100
INSTRUCTION = 8'd2 ; //loading the first value to ACC
#100
INSTRUCTION = 8'd7 ; //Display the loaded value on the output port
#100
IN_DATA = 8'b01010101; 
INSTRUCTION = 8'd1; //loading A register by 01010101
#100
INSTRUCTION = 8'd6 ; //xoring with ACC
#100
INSTRUCTION = 8'd7 ; //Display the result on the output port
#100
$display( "Test Complete: OUT_DATA= %b expected %b", OUT_DATA, 8'b11111111);

///////////////////////////////////////////////////////////////////////////////
end 

//clock generator for 100 ns clock with 50% duty cycle
always 
#50  CLK =  ! CLK; 

endmodule 