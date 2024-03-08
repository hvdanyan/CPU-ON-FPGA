`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/08 13:23:13
// Design Name: 
// Module Name: ROM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// The place that stores instructions to be run.Now it's a series of instructions that can count the 14th number of the Fibonacci sequence.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// 0.02 give a tik delay
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ROM(
    input [7:0] addr,
    output reg [7:0] Byteout
);
wire [0:255][7:0] Memory;

    assign Memory[0] = 8'b00000000; // R1 = a
    assign Memory[1] = 8'b10100000;// R0 = R1
    assign Memory[2] = 8'b00000100; // R1 = 4 
    assign Memory[3] = 8'b10101000; // R0 = R0 + R1
    assign Memory[4] = 8'b01010010; // R1 = &addr
    assign Memory[5] = 8'b11001100; // M[R1]=R0
    assign Memory[6] = 8'b00000001; // R1 = 1
    assign Memory[7] = 8'b10100000; // R0 = R1
    assign Memory[8] = 8'b00000000; // R1 = a
    assign Memory[9] = 8'b11001100; // M[R1] = R0
    assign Memory[10] = 8'b01010010; // R1 = &addr
    assign Memory[11] = 8'b10010000; // R1 = M[R1]
    assign Memory[12] = 8'b11001100; // M[R1] = R0
    assign Memory[13] = 8'b01001000; // R1 = 72
    assign Memory[14] = 8'b10100000; // R0 = R1
    assign Memory[15] = 8'b01010000; // R1 = &T
    assign Memory[16] = 8'b11001100; // M[R1] = R0
    assign Memory[17] = 8'b00000000; // R1 = 0
    assign Memory[18] = 8'b10100000; // R0 = R1
    assign Memory[19] = 8'b01010001; // R1 = &i
    assign Memory[20] = 8'b11001100; // M[R1] = R0
    assign Memory[21] = 8'b01010000; // (START)R1 = &T
    assign Memory[22] = 8'b10110000; // R0 = M[R1]
    assign Memory[23] = 8'b01010001; // R1 = &i
    assign Memory[24] = 8'b10010000; // R1 = M[R1]
    assign Memory[25] = 8'b10000100; // R1 = -R1
    assign Memory[26] = 8'b10101000; // R0 = R0 + R1
    assign Memory[27] = 8'b00101011; // LOOP = 43
    assign Memory[28] = 8'b11101101; // if(R0>0)jump LOOP
    assign Memory[29] = 8'b01001100; // (OVER)R1 = 76
    assign Memory[30] = 8'b10110000; // R0 = M[R1]
    assign Memory[31] = 8'b01111111; // R1 = 127
    assign Memory[32] = 8'b11001100; // M[R1] = R0
    assign Memory[33] = 8'b01001101; // R1 = 77
    assign Memory[34] = 8'b10110000; // R0 = M[R1]
    assign Memory[35] = 8'b01111110; // R1 = 126
    assign Memory[36] = 8'b11001100; // M[R1] = R0
    assign Memory[37] = 8'b01001110; // R1 = 78
    assign Memory[38] = 8'b10110000; // R0 = M[R1]
    assign Memory[39] = 8'b01111101; // R1 = 125
    assign Memory[40] = 8'b11001100; // M[R1] = R0
    assign Memory[41] = 8'b00011101; // OVER = 29
    assign Memory[42] = 8'b11100011; // jump OVER
    assign Memory[43] = 8'b00000000; // (LOOP)R1 = 0
    assign Memory[44] = 8'b10100000; // R0 = R1
    assign Memory[45] = 8'b10011000; // R1 = R0 f+ R1
    assign Memory[46] = 8'b00000000; // R1 = a
    assign Memory[47] = 8'b10100000; // R0 = R1
    assign Memory[48] = 8'b01010001; // R1 = &i
    assign Memory[49] = 8'b10010000; // R1 = M[R1]
    assign Memory[50] = 8'b10101000; // R0 = R1 + R0
    assign Memory[51] = 8'b01010010; // R1 = &addr
    assign Memory[52] = 8'b11001100; // M[R1]=R0
    assign Memory[53] = 8'b00000100; // R1 = 4
    assign Memory[54] = 8'b10101000; // R0 = R0 + R1
    assign Memory[55] = 8'b01010011; // R1 = &addr2
    assign Memory[56] = 8'b11001100; // M[R1]=R0
    assign Memory[57] = 8'b00000100; // R1 = 4
    assign Memory[58] = 8'b10101000; // R0 = R0 + R1
    assign Memory[59] = 8'b01010100; // R1 = &addr3
    assign Memory[60] = 8'b11001100; // M[R1]=R0
    assign Memory[61] = 8'b01010010; // R1 = &addr
    assign Memory[62] = 8'b10010000; // R1 = M[R1]
    assign Memory[63] = 8'b10110000; // R0 = M[R1]
    assign Memory[64] = 8'b01010011; // R1 = &addr2
    assign Memory[65] = 8'b10010000; // R1 = M[R1]
    assign Memory[66] = 8'b10010000; // R1 = M[R1]
    assign Memory[67] = 8'b10111000; // R0 = R0 f+ R1
    assign Memory[68] = 8'b01010100; // R1 = &addr3
    assign Memory[69] = 8'b10010000; // R1 = M[R1]
    assign Memory[70] = 8'b11001100; // M[R1]=R0
    assign Memory[71] = 8'b00000010; // R1 = 2
    assign Memory[72] = 8'b10100100; // R0 = -R1
    assign Memory[73] = 8'b01010101; // R1 = &j
    assign Memory[74] = 8'b11001100; // M[R1] = R0
    assign Memory[75] = 8'b01101110; // (FULLADD)FULLADDEND = 110 // I met a bug here, as I errorly put (FULLADD) tag on the 75th line,causing line 75 keep jumping to itself.
    assign Memory[76] = 8'b11101101; // if j>0 jump FULLADDEND
    assign Memory[77] = 8'b00000001; // R1 = 1
    assign Memory[78] = 8'b10100000; // R0 = R1
    assign Memory[79] = 8'b01010010; // R1 = &addr
    assign Memory[80] = 8'b10010000; // R1 = M[R1]
    assign Memory[81] = 8'b10101000; // R0 = R0 + R1
    assign Memory[82] = 8'b01010010; // R1 = &addr
    assign Memory[83] = 8'b11001100; // M[R1]=R0
    assign Memory[84] = 8'b00000100; // R1 = 4
    assign Memory[85] = 8'b10101000; // R0 = R0 + R1
    assign Memory[86] = 8'b01010011; // R1 = &addr2
    assign Memory[87] = 8'b11001100; // M[R1]=R0
    assign Memory[88] = 8'b00000100; // R1 = 4
    assign Memory[89] = 8'b10101000; // R0 = R0 + R1
    assign Memory[90] = 8'b01010100; // R1 = &addr3
    assign Memory[91] = 8'b11001100; // M[R1]=R0
    assign Memory[92] = 8'b01010010; // R1 = &addr
    assign Memory[93] = 8'b10010000; // R1 = M[R1]
    assign Memory[94] = 8'b10110000; // R0 = M[R1]
    assign Memory[95] = 8'b01010011; // R1 = &addr2
    assign Memory[96] = 8'b10010000; // R1 = M[R1]
    assign Memory[97] = 8'b10010000; // R1 = M[R1]
    assign Memory[98] = 8'b10111000; // R0 = R0 f+ R1
    assign Memory[99] = 8'b01010100; // R1 = &addr3
    assign Memory[100] = 8'b10010000; // R1 = M[R1]
    assign Memory[101] = 8'b11001100; // M[R1]=R0
    assign Memory[102] = 8'b01010101; // R1 = &j
    assign Memory[103] = 8'b10110000; // R0 = M[R1]
    assign Memory[104] = 8'b00000001; // R1 = 1
    assign Memory[105] = 8'b10101000; // R0 = R0 + R1
    assign Memory[106] = 8'b01010101; // R1 = &j
    assign Memory[107] = 8'b11001100; // M[R1] = R0
    assign Memory[108] = 8'b01001011; // FULLADD = 75
    assign Memory[109] = 8'b11100011; // jump FULLADD
    assign Memory[110] = 8'b01010001; // (FULLADDEND)R1 = &i
    assign Memory[111] = 8'b10110000; // R0 = M[R1]
    assign Memory[112] = 8'b00000100; // R1 = 4
    assign Memory[113] = 8'b10101000; // R0 = R0 + R1
    assign Memory[114] = 8'b01010001; // R1 = &i
    assign Memory[115] = 8'b11001100; // M[R1] = R0
    assign Memory[116] = 8'b00010101; // START = 21
    assign Memory[117] = 8'b11100011; // jump START
DMux256way8bit DMux256way8bit_inst(Memory, addr, Byteout);

endmodule