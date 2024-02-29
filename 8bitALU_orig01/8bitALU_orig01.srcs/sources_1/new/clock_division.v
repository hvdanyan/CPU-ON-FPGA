`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/08 17:21:40
// Design Name: 
// Module Name: clock_division
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


module clock_division #(parameter DIVCLK_CNTMAX = 49999)(clk_in,divclk);
 input clk_in;
 output divclk;

 reg [31:0] cnt = 0; 
 reg divclk_reg = 0;
 always@(posedge clk_in) begin
 if(cnt == DIVCLK_CNTMAX) begin
 cnt <= 0;
 divclk_reg <= ~divclk_reg;
 end
 else
 cnt <= cnt + 1;
 end 
 assign divclk = divclk_reg;
endmodule
