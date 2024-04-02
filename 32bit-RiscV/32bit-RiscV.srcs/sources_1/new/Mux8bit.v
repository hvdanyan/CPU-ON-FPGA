`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/01 14:52:26
// Design Name: 
// Module Name: Mux8bit
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


module Mux8bit(
    input write,switch,
    output reg writeout0,writeout1
    );
     always@(switch,write)
       begin
           if( switch==0)
           begin
            writeout0 = write;
            writeout1 = 0;
           end
           if( switch==1)
           begin
            writeout0 = 0;
            writeout1 = write;
           end
       end
endmodule
