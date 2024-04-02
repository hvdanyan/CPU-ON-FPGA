`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/01 16:13:36
// Design Name: 
// Module Name: DMux4096way8bit
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


module DMux4096way8bit(
  input [0:4095][7:0] Memory,
  input [11:0] addr,
  output [7:0] Memoryout
    );
    wire [0:15] [7:0] M;
    DMux256way8bit DMux256way8bit_0(Memory[0:255], addr[7:0], M[0]);
    DMux256way8bit DMux256way8bit_1(Memory[256:511], addr[7:0], M[1]);
    DMux256way8bit DMux256way8bit_2(Memory[512:767], addr[7:0], M[2]);
    DMux256way8bit DMux256way8bit_3(Memory[768:1023], addr[7:0], M[3]);
    DMux256way8bit DMux256way8bit_4(Memory[1024:1279], addr[7:0], M[4]);
    DMux256way8bit DMux256way8bit_5(Memory[1280:1535], addr[7:0], M[5]);
    DMux256way8bit DMux256way8bit_6(Memory[1536:1791], addr[7:0], M[6]);
    DMux256way8bit DMux256way8bit_7(Memory[1792:2047], addr[7:0], M[7]);
    DMux256way8bit DMux256way8bit_8(Memory[2048:2303], addr[7:0], M[8]);
    DMux256way8bit DMux256way8bit_9(Memory[2304:2559], addr[7:0], M[9]);
    DMux256way8bit DMux256way8bit_10(Memory[2560:2815], addr[7:0], M[10]);
    DMux256way8bit DMux256way8bit_11(Memory[2816:3071], addr[7:0], M[11]);
    DMux256way8bit DMux256way8bit_12(Memory[3072:3327], addr[7:0], M[12]);
    DMux256way8bit DMux256way8bit_13(Memory[3328:3583], addr[7:0], M[13]);
    DMux256way8bit DMux256way8bit_14(Memory[3584:3839], addr[7:0], M[14]);
    DMux256way8bit DMux256way8bit_15(Memory[3840:4095], addr[7:0], M[15]);
    
     DMux16way8bit DMux16way8bit_0(M, addr[11:8], Memoryout);
endmodule
