`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/08 17:26:54
// Design Name: 
// Module Name: digitron_sel_decoder
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


module digitron_sel_decoder(
    input [1:0]bit_disp,
    output [3:0]seg_sel
    );

    reg [3:0] seg_sel_reg;

    always@(bit_disp)
    case(bit_disp)
        2'b00 : seg_sel_reg = 4'b1110;
        2'b01 : seg_sel_reg = 4'b1101;
        2'b10 : seg_sel_reg = 4'b1011;
        2'b11 : seg_sel_reg = 4'b0111;
        default : seg_sel_reg = 4'b1111;
    endcase

    assign seg_sel = seg_sel_reg;
endmodule
