`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2023 02:46:41 PM
// Design Name: 
// Module Name: STIM_alu_8_bit
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

`define CLOCK_STEP 50
`include "opcodes.vh"

`define assert( signal, value  )\
    if( signal !== value ) begin \
        $display( "ASSERTION FAILED %d != %d", signal, value); \
    end

module STIM_alu_8_bit(
    output reg [7:0] operand_a, operand_b, opcode,
    output reg CLK, RESET,
    
    input wire [7:0] alu_out,
    input wire carry
    );
    
    // memory to hold test data
    parameter NUM_TEST_CASES = 32;
    parameter NUM_TEST_PARAMETERS = 5;
    reg[ 7:0 ] test_data[(NUM_TEST_CASES * NUM_TEST_PARAMETERS):0];
    integer i;
    
    initial 
    begin 
        $readmemb( "STIM_ALU.mem", test_data );
        CLK = 1'b0;
        RESET = 1'b1;
         
        #`CLOCK_STEP
     
        $monitor( "time=%3d, RESET=%d, opcode=%d, operand_a=%d, operand_b=%d, alu_out=%d carry=%d", $time, RESET,
            opcode, operand_a, operand_b, alu_out, carry );
        
        for( i = 0; i < NUM_TEST_CASES ; i = i + 1 )
        begin
            $display( "Test #%d ", i );
            opcode = test_data[ i * NUM_TEST_PARAMETERS ];
            operand_a = test_data[ ( i * NUM_TEST_PARAMETERS ) + 1 ];
            operand_b = test_data[ ( i * NUM_TEST_PARAMETERS ) + 2 ];
            
            #`CLOCK_STEP
            //$display( "Test Complete: OUT_DATA= %d expected %d", alu_out, test_data[ ( i * NUM_TEST_PARAMETERS ) + 3 ]);
            
            if ( alu_out !== test_data[ ( i * NUM_TEST_PARAMETERS ) + 3 ] ) begin
                //$display( "Unexpected alu_out") ;
                //$display( "Unexpected alu_out %d", alu_out ) ;
            end
            if ( carry !== test_data[ ( i * NUM_TEST_PARAMETERS ) + 4 ] ) begin
                //$display( "Unexpected carry") ;
                //$display( "Unexpected carry %d", carry ) ;
            end
//            `assert( alu_out,  test_data[ ( i * NUM_TEST_PARAMETERS ) + 3 ]; );
//            `assert( carry, test_data[ ( i * NUM_TEST_PARAMETERS ) + 4 ] );
            RESET = 1'b0;
            #`CLOCK_STEP
            RESET = 1'b1;
            
        end
    end 
 
    always
    begin
        #`CLOCK_STEP CLK = ! CLK;
    end
 
endmodule
