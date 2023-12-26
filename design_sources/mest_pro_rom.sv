module mest_pro_rom#(
    parameter DEPTH = 256,
    parameter WORD_SIZE=28
)(
    input clk,
    input  [$clog2(DEPTH)-1     :0] address,
    output reg [WORD_SIZE-1 :0] o_data
);
reg [WORD_SIZE-1 :0] rom [DEPTH-1 :0];

initial begin
    $readmemb("/home/hastings/MESTProModel2/MESTProModel2.srcs/sources_1/new/prog.txt", rom); //Change Path
end

always @(posedge clk)
begin
    o_data <= rom[address];
end

endmodule