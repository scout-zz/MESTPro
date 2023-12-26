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

always begin
#50  clk = !clk;
end

reg [INSTRUCTION_SIZE-1 :0] rom [ROM_DEPTH-1 :0];

initial begin
    $readmemb("/home/abouzeid.10/Desktop/course/Project/prog.txt", rom);
end

initial begin
    i_reset_n =0;
    clk       =0;
    i_start   =0;
    repeat(10) @(posedge clk);
    i_reset_n =1;
    repeat(10) @(posedge clk);
    i_start   =1;
    @(posedge clk);
    i_start   =0;
end


always @(posedge clk)
begin
    i_instruction <= rom[o_prog_counter];
end

integer out_num;
initial out_num = 0;


always @(posedge clk)begin
    if(o_valid_result)begin
        $display("Result number %0d = %0d",out_num,o_result);
        $display("Carry  number %0d = %0d",out_num,o_carry);
        $display("Zero Flag  number %0d = %0d",out_num,o_zero_flag);
        out_num = out_num +1;
    end
end




always @(posedge clk)begin
    if(o_all_done)begin
        $display("Simulation Done!");
        $stop;
    end
end



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


endmodule