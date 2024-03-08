`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/24 10:22:08
// Design Name: 
// Module Name: Parity_Flag
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// The input ports are Reg_a, Reg_b, seg and CLK. The output port is Reg_parity.
// The value Reg_parity shows whether the output of ALU is zero.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Parity_Flag(CLK,Reg_a,Reg_b,seg,Reg_parity);
input [7:0] Reg_a;
input [7:0] Reg_b;
input [7:0] seg;
input CLK;
output reg Reg_parity;
reg p;
always@(posedge CLK)
begin p=seg[7]^seg[6]^seg[5]^seg[4]^seg[3]^seg[2]^seg[1]^seg[0];
  if (p==1)
  Reg_parity=1;//������1��Ϊ1
  else Reg_parity=0;
  end
endmodule
