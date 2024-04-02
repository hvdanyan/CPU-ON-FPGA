`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/01 17:08:14
// Design Name: 
// Module Name: register
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


module register(
   input CLK,write,
   input [7:0] Bytein,
   output [7:0] Byteout
    );
     reg [7:0]ByteMemo;
       always@(posedge CLK)
       if(write == 1)ByteMemo <= Bytein;
   
       assign Byteout = ByteMemo;
       
       initial begin
           ByteMemo = 8'b0; 
       end
endmodule
