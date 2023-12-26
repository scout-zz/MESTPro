`timescale 1ns / 1ps
module mest_pro_tb;


parameter OP_CODE_SIZE     = 4;
parameter INSTRUCTION_SIZE = OP_CODE_SIZE + 8 + 8 + 8;
parameter ROM_DEPTH = 256;

reg clk;
reg i_reset_n;
reg i_start;
wire [8-1 :0] o_result;
wire o_valid_result;
wire o_carry;
wire o_zero_flag;
wire o_all_done;

wire o_req;
wire [$clog2(ROM_DEPTH)-1  :0] o_prog_counter;
reg [INSTRUCTION_SIZE-1   :0] i_instruction;

mest_pro#(
   .OP_CODE_SIZE    (OP_CODE_SIZE    ),
   .INSTRUCTION_SIZE(INSTRUCTION_SIZE),
   .ROM_DEPTH       (ROM_DEPTH       )
)
DUT
(
    .clk            (clk            ),
    .i_reset_n      (i_reset_n      ),
    .i_start        (i_start        ),
    .o_result       (o_result       ),
    .o_valid_result (o_valid_result ),
    .o_carry        (o_carry        ),
    .o_zero_flag    (o_zero_flag    ),
    .o_all_done     (o_all_done     ),
    .o_req          (o_req          ),
    .o_prog_counter (o_prog_counter ),
    .i_instruction  (i_instruction  )
);

mest_pro_STIM my_mest_pro_STIM
(
    .clk            (clk            ),
    .i_reset_n      (i_reset_n      ),
    .i_start        (i_start        ),
    .o_result       (o_result       ),
    .o_valid_result (o_valid_result ),
    .o_carry        (o_carry        ),
    .o_zero_flag    (o_zero_flag    ),
    .o_all_done     (o_all_done     ),
    .o_req          (o_req          ),
    .o_prog_counter (o_prog_counter )
//    .i_instruction  (i_instruction  )
);

mest_pro_rom my_mest_pro_rom
(
    .clk            (clk            ),
    .address        (o_prog_counter ),
    .o_data         (i_instruction  )
);

endmodule