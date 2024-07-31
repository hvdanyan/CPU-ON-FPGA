`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 12:14:16 PM
// Design Name: 
// Module Name: GP_registers
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// GP stands for general purpose registers. The module is used to store the 32 general registers.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module GP_registers(
    input clock,
    input [4:0]write_reg,
    input [31:0]write_data,
    input [4:0]read_regA,
    input [4:0]read_regB,
    output [31:0]A,
    output [31:0]B,
    output [31:0]registers_testbench[31:0]
    );

    reg [31:0]registers[31:0];

    always @(posedge clock) begin
        if(write_reg != 0) begin
            registers[write_reg] <= write_data;
        end
    end

    assign A = read_regA ? registers[read_regA] : 32'h0;
    assign B = read_regB ? registers[read_regB] : 32'h0;

    assign registers_testbench = registers;

    initial
    begin
        //for (int i = 0 ; i<32; i = i+1)begin
        //registers[i] = 32'h0;
        //end
        registers[0] = 32'h0;
        registers[1] = 32'h0;
        registers[8] = 32'h0;
    end
    
endmodule
