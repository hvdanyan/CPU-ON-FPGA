`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/24 10:23:25
// Design Name: 
// Module Name: Sign_Flag
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// The variable Reg_sign is used to show whether the first number of seg is 0.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Sign_Flag(CLK,Reg_a,Reg_b,seg,Reg_sign);
input [7:0] Reg_a;
input [7:0] Reg_b;
input [7:0] seg;
input CLK;
output reg Reg_sign;
//reg [7:0] s;
always@(posedge CLK)
  if (seg[7]==0)
  Reg_sign=0;
  else Reg_sign=1;
endmodule
