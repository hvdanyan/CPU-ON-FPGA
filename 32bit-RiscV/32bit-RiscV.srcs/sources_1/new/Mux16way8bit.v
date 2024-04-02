`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/01 14:51:14
// Design Name: 
// Module Name: Mux16way8bit
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


module Mux16way8bit(
    input write,
    input [3:0] addr,
    output [0:15] writeout
    );
     wire m10, m11;
       Mux8bit Mux8bit_0 (write, addr[3], m10, m11);
   
       wire m20, m21, m22, m23;
       Mux8bit Mux8bit_1 (m10, addr[2], m20, m21);
       Mux8bit Mux8bit_2 (m11, addr[2], m22, m23);
   
       wire m30, m31, m32, m33, m34, m35, m36, m37;
       Mux8bit Mux8bit_3 (m20, addr[1], m30, m31);
       Mux8bit Mux8bit_4 (m21, addr[1], m32, m33);
       Mux8bit Mux8bit_5 (m22, addr[1], m34, m35);
       Mux8bit Mux8bit_6 (m23, addr[1], m36, m37);
       
       Mux8bit Mux8bit_7 (m30, addr[0], writeout[0], writeout[1]);
       Mux8bit Mux8bit_8 (m31, addr[0], writeout[2], writeout[3]);
       Mux8bit Mux8bit_9 (m32, addr[0], writeout[4], writeout[5]);
       Mux8bit Mux8bit_10 (m33, addr[0], writeout[6], writeout[7]);
       Mux8bit Mux8bit_11 (m34, addr[0], writeout[8], writeout[9]);
       Mux8bit Mux8bit_12 (m35, addr[0], writeout[10], writeout[11]);
       Mux8bit Mux8bit_13 (m36, addr[0], writeout[12], writeout[13]);
       Mux8bit Mux8bit_14 (m37, addr[0], writeout[14], writeout[15]);
endmodule
