`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 11:55:35 AM
// Design Name: 
// Module Name: alu_8_bit
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
// OpCode opcode Set
// 0010	Add	
// 0011	Sub	
// 0100	AND	
// 0101	OR	
// 0110	XOR	
// 0111	Out
// 
//////////////////////////////////////////////////////////////////////////////////

`include "opcodes.vh"

module alu_8_bit(
    input [7:0] operand_a, operand_b, opcode,
    input CLK, RESET,
    
    output reg [7:0] alu_out,
    output reg carry
    );
    
always @(posedge CLK or negedge RESET) // sensitivity list 
begin  
    if (!RESET) begin 
        carry <= 0;
        alu_out <= 8'b0;
    end
    else begin
        case( opcode )
            `OP_ADD : {carry, alu_out[7:0]} <= operand_a + operand_b;
            `OP_SUB : {carry, alu_out[7:0]} <= operand_a - operand_b;
            `OP_AND : alu_out[7:0] <= operand_a & operand_b;
            `OP_OR : alu_out[7:0] <= operand_a | operand_b;
            `OP_XOR : alu_out[7:0] <= operand_a ^ operand_b;
            `OP_SRAC : alu_out[7:0] <= operand_a >>> operand_b;
            `OP_SRAC : alu_out[7:0] <= operand_a >>> operand_b;
            default : $display( "Uknown opcode");       
        endcase
    end 
end
endmodule