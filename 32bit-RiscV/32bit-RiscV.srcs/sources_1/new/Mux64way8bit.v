`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/01 14:55:23
// Design Name: 
// Module Name: Mux64way8bit
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


module Mux64way8bit(
    input write,
    input [5:0] addr,
    output [0:63] writeout
    );
     wire m10, m11;
          Mux8bit Mux8bit_0 (write, addr[3], m10, m11);
      
          wire m20, m21, m22, m23;
          Mux8bit Mux8bit_1 (m10, addr[2], m20, m21);
          Mux8bit Mux8bit_2 (m11, addr[2], m22, m23);
          
           Mux16way8bit Mux16way8bit_0 (m20, addr[3:0], writeout[0:15]);
           Mux16way8bit Mux16way8bit_1 (m21, addr[3:0], writeout[16:31]);
           Mux16way8bit Mux16way8bit_2 (m22, addr[3:0], writeout[32:47]);
           Mux16way8bit Mux16way8bit_3 (m23, addr[3:0], writeout[48:63]);
endmodule
