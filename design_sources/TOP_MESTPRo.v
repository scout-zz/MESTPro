`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2023 01:55:59 PM
// Design Name: 
// Module Name: TOP_MESTPRo
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


// This is the second version of MESTPro
// it contains CLK and RESET

module MestPro_V2
(
  //input ports
  input wire [7:0] IN_DATA,
  input wire [7:0] INSTRUCTION,
  input wire CLK,
  input wire RESET, 
  
  //output ports
  output reg [7:0] OUT_DATA

);

reg [7:0] A;  //A Register
reg [7:0] ACC;  //ACC Register

always @(posedge CLK or negedge RESET) // sensitivity list 
begin  
    if (!RESET) begin 
		ACC= 8'd0 ; //initialize ACC to zero
		A= 8'd0; //initialize A to zero
		OUT_DATA= 8'd0 ; //initialize temp ACC to zero
	end
    else begin
        if ( INSTRUCTION == 1 ) begin
            A = IN_DATA ;        
        end
        else if ( INSTRUCTION == 2 ) begin
            ACC = ACC + A ; 
        end
        else if ( INSTRUCTION == 3 ) begin
            ACC = ACC - A ;
        end
        else if ( INSTRUCTION == 4 ) begin
            ACC = ACC & A ;
        end
        else if ( INSTRUCTION == 5 ) begin
            ACC = ACC | A ;
        end
        else if ( INSTRUCTION == 6) begin
            ACC = ACC ^ A ;
        end
        else if ( INSTRUCTION == 7 ) begin
            OUT_DATA= ACC ;
        end
        else begin
            $display("Error in Instruction");
        end
	end	
end
endmodule
