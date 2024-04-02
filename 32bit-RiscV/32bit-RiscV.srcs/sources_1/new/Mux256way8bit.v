`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/01 15:04:03
// Design Name: 
// Module Name: Mux256way8bit
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


module Mux256way8bit(
   input write,
   input [7:0]addr,
   output [0:255]writeout
    );
    wire m10, m11;
        Mux8bit Mux8bit_0 (write, addr[7], m10, m11);
        
        wire m20, m21, m22, m23;
        Mux8bit Mux8bit_1 (m10, addr[6], m20, m21);
        Mux8bit Mux8bit_2 (m11, addr[6], m22, m23);
        
        wire m30, m31, m32, m33, m34, m35, m36, m37;
        Mux8bit Mux8bit_3 (m20, addr[5], m30, m31);
        Mux8bit Mux8bit_4 (m21, addr[5], m32, m33);
        Mux8bit Mux8bit_5 (m22, addr[5], m34, m35);
        Mux8bit Mux8bit_6 (m23, addr[5], m36, m37);
        
        wire m40, m41, m42, m43, m44, m45, m46, m47, m48, m49, m410, m411, m412, m413, m414, m415;
        Mux8bit Mux8bit_7 (m30, addr[4], m40, m41);
        Mux8bit Mux8bit_8 (m31, addr[4], m42, m43);
        Mux8bit Mux8bit_9 (m32, addr[4], m44, m45);
        Mux8bit Mux8bit_10 (m33, addr[4], m46, m47);
        Mux8bit Mux8bit_11 (m34, addr[4], m48, m49);
        Mux8bit Mux8bit_12 (m35, addr[4], m410, m411);
        Mux8bit Mux8bit_13 (m36, addr[4], m412, m413);
        Mux8bit Mux8bit_14 (m37, addr[4], m414, m415);
        
        Mux16way8bit Mux16way8bit_0 (m40, addr[3:0], writeout[0:15]);
        Mux16way8bit Mux16way8bit_1 (m41, addr[3:0], writeout[16:31]);
        Mux16way8bit Mux16way8bit_2 (m42, addr[3:0], writeout[32:47]);
        Mux16way8bit Mux16way8bit_3 (m43, addr[3:0], writeout[48:63]);
        Mux16way8bit Mux16way8bit_4 (m44, addr[3:0], writeout[64:79]);
        Mux16way8bit Mux16way8bit_5 (m45, addr[3:0], writeout[80:95]);
        Mux16way8bit Mux16way8bit_6 (m46, addr[3:0], writeout[96:111]);
        Mux16way8bit Mux16way8bit_7 (m47, addr[3:0], writeout[112:127]);
        Mux16way8bit Mux16way8bit_8 (m48, addr[3:0], writeout[128:143]);
        Mux16way8bit Mux16way8bit_9 (m49, addr[3:0], writeout[144:159]);
        Mux16way8bit Mux16way8bit_10 (m410, addr[3:0], writeout[160:175]);
        Mux16way8bit Mux16way8bit_11 (m411, addr[3:0], writeout[176:191]);
        Mux16way8bit Mux16way8bit_12 (m412, addr[3:0], writeout[192:207]);
        Mux16way8bit Mux16way8bit_13 (m413, addr[3:0], writeout[208:223]);
        Mux16way8bit Mux16way8bit_14 (m414, addr[3:0], writeout[224:239]);
        Mux16way8bit Mux16way8bit_15 (m415, addr[3:0], writeout[240:255]);
endmodule
