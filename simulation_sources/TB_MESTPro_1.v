`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2023 02:05:59 PM
// Design Name: 
// Module Name: TB_MESTPro_1
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


module TB_MESTPro_1;

wire [7:0] IN_DATA;
wire [7:0] INSTRUCTION;
wire [7:0] OUT_DATA;
wire CLK;
wire RESET;

MestPro_V2 		My_Pro		(.IN_DATA(IN_DATA), .INSTRUCTION(INSTRUCTION), .OUT_DATA(OUT_DATA), .CLK(CLK), .RESET(RESET)) ;
MestPro_STIM_V2 My_Pro_Stim (.IN_DATA(IN_DATA), .INSTRUCTION(INSTRUCTION), .OUT_DATA(OUT_DATA), .CLK(CLK), .RESET(RESET)) ;

endmodule

