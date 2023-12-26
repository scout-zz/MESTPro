module mest_pro_decode
(
    input [28-1 :0] i_decode_reg,
// Decode stage
    output [4-1 :0] o_op_code,
    output [8-1 :0] o_const_K,
    output [8-1 :0] o_operand_a,
    output [8-1 :0] o_operand_b
);



// Decode Stage
assign o_op_code       = i_decode_reg[28-1    : 24];
assign o_const_K       = i_decode_reg[23      : 16];
assign o_operand_a     = i_decode_reg[15      :  8];
assign o_operand_b     = i_decode_reg[7       :  0];

endmodule