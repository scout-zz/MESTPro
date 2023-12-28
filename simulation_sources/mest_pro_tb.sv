`timescale 1ns / 1ps
module mest_pro_tb;


parameter OP_CODE_SIZE     = 4;
parameter INSTRUCTION_SIZE = OP_CODE_SIZE + 8 + 8 + 8;
parameter ROM_DEPTH = 65536;

reg clk;
reg i_reset_n;
reg i_start;
wire [8-1 :0] o_result;
wire o_valid_result;
wire o_carry;
wire o_zero_flag;
wire o_all_done;

//wire o_req;
wire [$clog2(ROM_DEPTH)-1  :0] o_prog_counter;
reg [INSTRUCTION_SIZE-1   :0] i_instruction;
reg [INSTRUCTION_SIZE-1   :0] data2store;
wire mm_WE;
wire mm_CS;
wire mm_RESET;
wire mm_ERROR;


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
    .i_instruction  (i_instruction  ),
    .m_ERROR        (mm_ERROR       ),
    .WE             (mm_WE),
    .CS             (mm_CS),
    .RESET          (mm_RESET),
    .data2store     (data2store)    
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
    .o_all_done     (o_all_done     )
);


TOP_MESTProMem3 my_mest_pro_memory
(
    .CLK            (clk            ),
    .addr           (o_prog_counter ),
    .in_dat         (data2store     ),
    .WE             (mm_WE           ),
    .CS             (mm_CS           ),
    .RESET          (mm_RESET        ),
    .o_dat          (i_instruction  ),
    .ERROR          (mm_ERROR)
);


endmodule