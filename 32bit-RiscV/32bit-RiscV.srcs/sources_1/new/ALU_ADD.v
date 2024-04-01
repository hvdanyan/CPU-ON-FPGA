`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/01 16:41:28
// Design Name: 
// Module Name: ALU_ADD
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


module ALU_ADD(
    input [31:0] A,
    input [31:0] B,
    output [31:0] result,
    output zero,
    output less
);
    assign result = A + B;
    assign zero = (result == 0);  // �жϽ���Ƿ�Ϊ��
    assign less = (A < B);  // �ж� A �Ƿ�С�� B
    
endmodule