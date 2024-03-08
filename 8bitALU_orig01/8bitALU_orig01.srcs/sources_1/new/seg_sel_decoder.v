`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/08 17:26:54
// Design Name: 
// Module Name: seg_sel_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Another basic demo that helps to show the digits.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module seg_sel_decoder(bit_disp,seg_sel);
input [1:0] bit_disp;
output reg [3:0] seg_sel;
always@(bit_disp)
case(bit_disp)
 2'b00 : seg_sel = 4'b1110;
 2'b01 : seg_sel = 4'b1101;
 2'b10 : seg_sel = 4'b1011;
 2'b11 : seg_sel = 4'b0111;
default : seg_sel = 4'b1111;
endcase
endmodule
