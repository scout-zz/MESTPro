`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2023 02:32:49 PM
// Design Name: 
// Module Name: TB_alu_8_bit
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


module TB_alu_8_bit;

wire [7:0] OP_A, OP_B, OPCODE, ALU_OUT;
wire CARRY;
wire CLK, RESET ;

alu_8_bit test_alu( OP_A, OP_B,OPCODE, CLK, RESET, ALU_OUT, CARRY );
STIM_alu_8_bit test_stim( OP_A, OP_B,OPCODE, CLK, RESET, ALU_OUT, CARRY );

endmodule
