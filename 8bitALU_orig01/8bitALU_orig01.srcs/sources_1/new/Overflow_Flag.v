`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/24 10:20:47
// Design Name: 
// Module Name: Overflow_Flag
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// In this module, the input ports are Reg_a, Reg_b, seg and CLK.the output port is the Reg_overflow.
// Reg_overflow is affected by Reg and shows whether overflow happens in ALU or not.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Overflow_Flag(CLK,Reg_a,Reg_b,seg,Reg_overflow);
input [7:0] Reg_a;
input [7:0] Reg_b;
input [7:0] seg;
input CLK;
output reg Reg_overflow;
//reg [7:0] s;
always@(posedge CLK)
  //s=Reg_a+Reg_b;
  Reg_overflow=Reg_a[7] & Reg_b[7] & ~seg[7] | ~Reg_a[7] & ~Reg_b[7] & seg[7];
  //����������ӡ������ķ���λΪ0���������ʱ����λ����1����ʱ���λ��1������������ӡ������ķ���λΪ1���������ʱ����λ����0����ʱ���λ��1��//
endmodule
