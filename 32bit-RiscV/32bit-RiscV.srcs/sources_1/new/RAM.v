`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 12:48:47 PM
// Design Name: 
// Module Name: RAM
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


module RAM #(
    parameter BIT_INDEX = 31
    )(
    input clock,
    input [BIT_INDEX:0]addr,
    input [31:0]data_in,
    input write_en,
    output [31:0]data_out
    );
endmodule
