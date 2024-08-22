`timescale 1ns / 1ps

module cache_instr #(
    parameter BIT_INDEX = 11
    )(
    input clock,
    input [BIT_INDEX:0]addr,
    output [31:0]data,
    output instr_hit
    );

    wire instr_hit = 1;

    wire [31:0]Memory[0:1023];

    assign Memory[0] = 32'h00000000;
    assign Memory[1] = 32'h00000000;
    assign Memory[2] = 32'h00000000;
    

    assign Memory[3] = 32'hf0000113; // c: li sp,-256
    assign Memory[4] = 32'h094000ef; // 10: jal a4 <main>
    assign Memory[5] = 32'h000012b7; // 14: lui t0,0x1
    assign Memory[6] = 32'hffc28293; // 18: addi t0,t0,-4 # ffc <__global_pointer$+0x6f8>
    assign Memory[7] = 32'h00a2a023; // 1c: sw a0,0(t0)
    assign Memory[8] = 32'h0000006f; // 20: j 20 <loop>
    assign Memory[9] = 32'hfd010113; // 24: addi sp,sp,-48
    assign Memory[10] = 32'h02812623; // 28: sw s0,44(sp)
    assign Memory[11] = 32'h03010413; // 2c: addi s0,sp,48
    assign Memory[12] = 32'hfca42e23; // 30: sw a0,-36(s0)
    assign Memory[13] = 32'h000017b7; // 34: lui a5,0x1
    assign Memory[14] = 32'hff878793; // 38: addi a5,a5,-8 # ff8 <__global_pointer$+0x6f4>
    assign Memory[15] = 32'hfef42623; // 3c: sw a5,-20(s0)
    assign Memory[16] = 32'h0440006f; // 40: j 84 <seriprint+0x60>
    assign Memory[17] = 32'hfdc42783; // 44: lw a5,-36(s0)
    assign Memory[18] = 32'h0007c783; // 48: lbu a5,0(a5)
    assign Memory[19] = 32'h00078713; // 4c: mv a4,a5
    assign Memory[20] = 32'h800007b7; // 50: lui a5,0x80000
    assign Memory[21] = 32'h00f70733; // 54: add a4,a4,a5
    assign Memory[22] = 32'hfec42783; // 58: lw a5,-20(s0)
    assign Memory[23] = 32'h00e7a023; // 5c: sw a4,0(a5) # 80000000 <__global_pointer$+0x7ffff6fc>
    assign Memory[24] = 32'h00000013; // nop
    assign Memory[25] = 32'hfec42783; // 64: lw a5,-20(s0)
    assign Memory[26] = 32'h0007a783; // 68: lw a5,0(a5)
    assign Memory[27] = 32'h01f7d713; // 6c: srli a4,a5,0x1f
    assign Memory[28] = 32'h00100793; // 70: li a5,1
    assign Memory[29] = 32'hfef708e3; // 74: beq a4,a5,64 <seriprint+0x40>
    assign Memory[30] = 32'hfdc42783; // 78: lw a5,-36(s0)
    assign Memory[31] = 32'h00178793; // 7c: addi a5,a5,1
    assign Memory[32] = 32'hfcf42e23; // 80: sw a5,-36(s0)
    assign Memory[33] = 32'hfdc42783; // 84: lw a5,-36(s0)
    assign Memory[34] = 32'h0007c783; // 88: lbu a5,0(a5)
    assign Memory[35] = 32'hfa079ce3; // 8c: bnez a5,44 <seriprint+0x20>
    assign Memory[36] = 32'h00000013; // nop
    assign Memory[37] = 32'h00000013; // nop
    assign Memory[38] = 32'h02c12403; // 98: lw s0,44(sp)
    assign Memory[39] = 32'h03010113; // 9c: addi sp,sp,48
    assign Memory[40] = 32'h00008067; // ret
    assign Memory[41] = 32'hfd010113; // a4: addi sp,sp,-48
    assign Memory[42] = 32'h02112623; // a8: sw ra,44(sp)
    assign Memory[43] = 32'h02812423; // ac: sw s0,40(sp)
    assign Memory[44] = 32'h03010413; // b0: addi s0,sp,48
    assign Memory[45] = 32'h6c6c67b7; // b4: lui a5,0x6c6c6
    assign Memory[46] = 32'h54878793; // b8: addi a5,a5,1352 # 6c6c6548 <__global_pointer$+0x6c6c5c44>
    assign Memory[47] = 32'hfcf42e23; // bc: sw a5,-36(s0)
    assign Memory[48] = 32'h6f5727b7; // c0: lui a5,0x6f572
    assign Memory[49] = 32'h06f78793; // c4: addi a5,a5,111 # 6f57206f <__global_pointer$+0x6f57176b>
    assign Memory[50] = 32'hfef42023; // c8: sw a5,-32(s0)
    assign Memory[51] = 32'h0a6477b7; // cc: lui a5,0xa647
    assign Memory[52] = 32'hc7278793; // d0: addi a5,a5,-910 # a646c72 <__global_pointer$+0xa64636e>
    assign Memory[53] = 32'hfef42223; // d4: sw a5,-28(s0)
    assign Memory[54] = 32'hfe042423; // d8: sw zero,-24(s0)
    assign Memory[55] = 32'hfe042623; // dc: sw zero,-20(s0)
    assign Memory[56] = 32'hfdc40793; // e0: addi a5,s0,-36
    assign Memory[57] = 32'h00078513; // e4: mv a0,a5
    assign Memory[58] = 32'hf3dff0ef; // e8: jal 24 <seriprint>
    assign Memory[59] = 32'h00000793; // ec: li a5,0
    assign Memory[60] = 32'h00078513; // f0: mv a0,a5
    assign Memory[61] = 32'h02c12083; // f4: lw ra,44(sp)
    assign Memory[62] = 32'h02812403; // f8: lw s0,40(sp)
    assign Memory[63] = 32'h03010113; // fc: addi sp,sp,48
    assign Memory[64] = 32'h00008067; // ret

    assign data = Memory[addr[BIT_INDEX:2]];

endmodule
