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
    output [31:0]B
    );

    reg [31:0]registers[31:0];
endmodule
