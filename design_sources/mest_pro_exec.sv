`include "opcodes.vh"
`include "param.vh"

module mest_pro_exec(
    input clk,
    input i_reset_n,
    input i_execute,
    input [4-1 :0] i_op_code,
    input [8-1 :0] i_operand1,
    input [8-1 :0] i_operand2,
    output reg o_exec_done,
    output reg [8-1 :0] o_result,
    output reg o_carry,
    output reg o_zero_flag,
    output reg o_jump,
    output reg o_return_pc,
    output reg o_end_of_code,
    output reg o_rega
);


reg [9-1 :0] inter_result;
reg [ `DATA_BITS-1:0 ] REGA;

always @(*)
begin
    case(i_op_code)
    `OP_ADD: begin
        inter_result = i_operand1 + i_operand2;
        o_jump        = 1'd0;
        o_end_of_code = 1'd0;
        o_return_pc   = 1'b0;
    end
    `OP_SUB: begin
        inter_result = i_operand1 - i_operand2;
        o_jump        = 1'd0;
        o_end_of_code = 1'd0;
        o_return_pc   = 1'b0;
    end
    `OP_MULTIPLY: begin
        inter_result = i_operand1 * i_operand2;
        o_jump        = 1'd0;
        o_end_of_code = 1'd0;
        o_return_pc   = 1'b0;
    end
    `OP_AND: begin
        inter_result = i_operand1 & i_operand2;
        o_jump        = 1'd0;
        o_end_of_code = 1'd0;
        o_return_pc   = 1'b0;
    end
    `OP_OR: begin
        inter_result = i_operand1 | i_operand2;
        o_jump        = 1'd0;
        o_end_of_code = 1'd0;
        o_return_pc   = 1'b0;
    end
    `OP_SROP1 : begin
        inter_result = i_operand1 >> 1;
        o_jump        = 1'd0;
        o_end_of_code = 1'd0;
        o_return_pc   = 1'b0;
    end
    `OP_SLOP1: begin
        inter_result = i_operand1 << 1;
        o_jump        = 1'd0;
        o_end_of_code = 1'd0;
        o_return_pc   = 1'b0;
    end
    `OP_NEGOP1: begin
        inter_result = ~i_operand1;
        o_jump        = 1'd0;
        o_end_of_code = 1'd0;
        o_return_pc   = 1'b0;
    end
    `OP_JMP: begin
        o_jump = 1'd1;
        inter_result  = 8'd0;
        o_end_of_code = 1'd0;
        o_return_pc   = 1'b0;
    end
    `OP_RET: begin
        o_return_pc = 1'd1;
        inter_result  = 8'd0;
        o_jump        = 1'd0;
        o_end_of_code = 1'd0;
    end  
    `OP_MVIA: begin
        REGA = i_operand1; 
        o_jump        = 1'd0;
        o_end_of_code = 1'd0;
        o_return_pc   = 1'b0;       
    end
    `OP_HALT: begin
        o_end_of_code = 1'd1;
        inter_result  = 8'd0;
        o_jump        = 1'd0;
        o_return_pc   = 1'b0;
    end
    default: begin
        inter_result  = 8'd0;
        o_jump        = 1'd0;
        o_end_of_code = 1'd0;
        o_return_pc   = 1'b0;
    end
    endcase
end

// Sequential Logic
always @(posedge clk or negedge i_reset_n)
begin
    if(~i_reset_n)
        begin
            o_result    <= 8'd0;
            o_carry     <= 1'd0;
            o_zero_flag <= 1'd0;
            o_exec_done <= 1'd0;
        end 
    else
        begin
            o_result    <= inter_result[8-1 :0];
            o_carry     <= inter_result[9-1];
            o_zero_flag <= ~(|inter_result);
            o_exec_done <= i_execute;
        end 
end



endmodule