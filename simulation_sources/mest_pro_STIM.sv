`timescale 1ns / 1ps
module mest_pro_STIM
#(
parameter OP_CODE_SIZE     = 4, INSTRUCTION_SIZE = OP_CODE_SIZE + 8 + 8 + 8, ROM_DEPTH = 256
)
(
output reg clk,
output reg i_reset_n,
output reg i_start,
input wire [8-1 :0] o_result,
input wire o_valid_result,
input wire o_carry,
input wire o_zero_flag,
input wire o_all_done,

input wire o_req,
input wire [$clog2(ROM_DEPTH)-1  :0] o_prog_counter,
output reg [INSTRUCTION_SIZE-1   :0] i_instruction
);

always begin
#50  clk = !clk;
end

//reg [INSTRUCTION_SIZE-1 :0] rom [ROM_DEPTH-1 :0];

//initial begin
//    $readmemb("/home/hastings/MESTProModel2/MESTProModel2.srcs/sources_1/new/prog.txt", rom); //Change Path
//end

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


//always @(posedge clk)
//begin
//    i_instruction <= rom[o_prog_counter];
//end

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

endmodule