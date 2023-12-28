module ROM#(
    parameter DEPTH = 8,
    parameter WORD_SIZE=16
)(
    input clk,
    input  [$clog2(DEPTH)-1     :0] address,
    output reg [WORD_SIZE-1 :0] o_data
);
reg [WORD_SIZE-1 :0] rom [DEPTH-1 :0];

initial begin
    $readmemb("prog.txt", rom);
end

always @(posedge clk)
begin
    o_data <= rom[address];
end

endmodule