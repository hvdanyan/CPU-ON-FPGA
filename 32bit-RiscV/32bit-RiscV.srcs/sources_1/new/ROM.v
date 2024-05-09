`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 11:01:28 AM
// Design Name: 
// Module Name: ROM
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


module ROM #(
    parameter BIT_INDEX = 11
    )(
    input clock,
    input [BIT_INDEX:0]addr,
    output [31:0]data
    );

    wire [0:1023]Memory[31:0];

    assign Memory[0] = 32'h0;
    assign Memory[1] = 32'h0;
    assign Memory[2] = 32'h0;
    assign Memory[3] = 32'hFFF00113; //li	sp,-1

    assign data = Memory[addr[BIT_INDEX:2]];

endmodule

