`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/01 15:50:54
// Design Name: 
// Module Name: DMux8bit
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


module DMux8bit(
    input [7:0]Memory0,Memory1,
    input switch,
    output reg [7:0]Memoryout
    );
     always@(switch,Memory0,Memory1)
       begin
           if( switch==0 ) Memoryout = Memory0;
           if( switch==1 ) Memoryout = Memory1;
       end
endmodule
