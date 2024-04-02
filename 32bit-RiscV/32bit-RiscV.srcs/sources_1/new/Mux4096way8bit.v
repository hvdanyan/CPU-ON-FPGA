`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/01 15:00:01
// Design Name: 
// Module Name: Mux4096way8bit
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


module Mux4096way8bit(
   input write,
   input [11:0] addr,
   output [0:4095] writeout
    );
    wire m10, m11;
        Mux8bit Mux8bit_0 (write, addr[11], m10, m11);
        
        wire m20, m21, m22, m23;
        Mux8bit Mux8bit_1 (m10, addr[10], m20, m21);
        Mux8bit Mux8bit_2 (m11, addr[10], m22, m23);
        
        wire m30, m31, m32, m33, m34, m35, m36, m37;
        Mux8bit Mux8bit_3 (m20, addr[9], m30, m31);
        Mux8bit Mux8bit_4 (m21, addr[9], m32, m33);
        Mux8bit Mux8bit_5 (m22, addr[9], m34, m35);
        Mux8bit Mux8bit_6 (m23, addr[9], m36, m37);
        
        wire m40, m41, m42, m43, m44, m45, m46, m47, m48, m49, m410, m411, m412, m413, m414, m415;
        Mux8bit Mux8bit_7 (m30, addr[8], m40, m41);
        Mux8bit Mux8bit_8 (m31, addr[8], m42, m43);
        Mux8bit Mux8bit_9 (m32, addr[8], m44, m45);
        Mux8bit Mux8bit_10 (m33, addr[8], m46, m47);
        Mux8bit Mux8bit_11 (m34, addr[8], m48, m49);
        Mux8bit Mux8bit_12 (m35, addr[8], m410, m411);
        Mux8bit Mux8bit_13 (m36, addr[8], m412, m413);
        Mux8bit Mux8bit_14 (m37, addr[8], m414, m415);
        
         Mux256way8bit Mux256way8bit_0 (m40, addr[7:0], writeout[0:255]);
           Mux256way8bit Mux256way8bit_1 (m41, addr[7:0], writeout[256:511]);
           Mux256way8bit Mux256way8bit_2 (m42, addr[7:0], writeout[512:767]);
           Mux256way8bit Mux256way8bit_3 (m43, addr[7:0], writeout[768:1023]);
           Mux256way8bit Mux256way8bit_4 (m44, addr[7:0], writeout[1024:1279]);
           Mux256way8bit Mux256way8bit_5 (m45, addr[7:0], writeout[1280:1535]);
           Mux256way8bit Mux256way8bit_6 (m46, addr[7:0], writeout[1536:1791]);
           Mux256way8bit Mux256way8bit_7 (m47, addr[7:0], writeout[1792:2047]);
           Mux256way8bit Mux256way8bit_8 (m48, addr[7:0], writeout[2048:2303]);
           Mux256way8bit Mux256way8bit_9 (m49, addr[7:0], writeout[2304:2559]);
           Mux256way8bit Mux256way8bit_10 (m410, addr[7:0], writeout[2560:2815]);
           Mux256way8bit Mux256way8bit_11 (m411, addr[7:0], writeout[2816:3071]);
           Mux256way8bit Mux256way8bit_12 (m412, addr[7:0], writeout[3072:3327]);
           Mux256way8bit Mux256way8bit_13 (m413, addr[7:0], writeout[3328:3583]);
           Mux256way8bit Mux256way8bit_14 (m414, addr[7:0], writeout[3584:3839]);
           Mux256way8bit Mux256way8bit_15 (m415, addr[7:0], writeout[3840:4095]);
endmodule
