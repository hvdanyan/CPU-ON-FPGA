`timescale 1ns / 1ps

module cache_instr #(
    parameter BIT_INDEX = 11
    )(
    input clock,
    input [BIT_INDEX:0]addr,
    output [31:0]data
    );

    wire [31:0]Memory[0:1023];

    assign Memory[0] = 32'h00000000;
    assign Memory[1] = 32'h00000000;
    assign Memory[2] = 32'h00000000;
    

    assign Memory[3] = 32'hf0000113; // c: li sp,-256
    assign Memory[4] = 32'h08c000ef; // 10: jal 9c <main>
    assign Memory[5] = 32'h000012b7; // 14: lui t0,0x1
    assign Memory[6] = 32'hffc28293; // 18: addi t0,t0,-4 # ffc <__global_pointer$+0x720>
    assign Memory[7] = 32'h00a2a023; // 1c: sw a0,0(t0)
    assign Memory[8] = 32'h0000006f; // 20: j 20 <loop>
    assign Memory[9] = 32'hfd010113; // 24: addi sp,sp,-48
    assign Memory[10] = 32'h02812623; // 28: sw s0,44(sp)
    assign Memory[11] = 32'h03010413; // 2c: addi s0,sp,48
    assign Memory[12] = 32'hfca42e23; // 30: sw a0,-36(s0)
    assign Memory[13] = 32'hfcb42c23; // 34: sw a1,-40(s0)
    assign Memory[14] = 32'h000017b7; // 38: lui a5,0x1
    assign Memory[15] = 32'hff478793; // 3c: addi a5,a5,-12 # ff4 <__global_pointer$+0x718>
    assign Memory[16] = 32'hfef42623; // 40: sw a5,-20(s0)
    assign Memory[17] = 32'h0340006f; // 44: j 78 <seriscan+0x54>
    assign Memory[18] = 32'h00000013; // nop
    assign Memory[19] = 32'hfec42783; // 4c: lw a5,-20(s0)
    assign Memory[20] = 32'h0007a783; // 50: lw a5,0(a5)
    assign Memory[21] = 32'hfe07dce3; // 54: bgez a5,4c <seriscan+0x28>
    assign Memory[22] = 32'hfec42783; // 58: lw a5,-20(s0)
    assign Memory[23] = 32'h0007a783; // 5c: lw a5,0(a5)
    assign Memory[24] = 32'h0ff7f713; // 60: zext.b a4,a5
    assign Memory[25] = 32'hfdc42783; // 64: lw a5,-36(s0)
    assign Memory[26] = 32'h00e78023; // 68: sb a4,0(a5)
    assign Memory[27] = 32'hfdc42783; // 6c: lw a5,-36(s0)
    assign Memory[28] = 32'h00178793; // 70: addi a5,a5,1
    assign Memory[29] = 32'hfcf42e23; // 74: sw a5,-36(s0)
    assign Memory[30] = 32'hfd842783; // 78: lw a5,-40(s0)
    assign Memory[31] = 32'hfff78713; // 7c: addi a4,a5,-1
    assign Memory[32] = 32'hfce42c23; // 80: sw a4,-40(s0)
    assign Memory[33] = 32'hfc0792e3; // 84: bnez a5,48 <seriscan+0x24>
    assign Memory[34] = 32'h00000013; // nop
    assign Memory[35] = 32'h00000013; // nop
    assign Memory[36] = 32'h02c12403; // 90: lw s0,44(sp)
    assign Memory[37] = 32'h03010113; // 94: addi sp,sp,48
    assign Memory[38] = 32'h00008067; // ret
    assign Memory[39] = 32'hfe010113; // 9c: addi sp,sp,-32
    assign Memory[40] = 32'h00112e23; // a0: sw ra,28(sp)
    assign Memory[41] = 32'h00812c23; // a4: sw s0,24(sp)
    assign Memory[42] = 32'h02010413; // a8: addi s0,sp,32
    assign Memory[43] = 32'h40000793; // ac: li a5,1024
    assign Memory[44] = 32'hfef42623; // b0: sw a5,-20(s0)
    assign Memory[45] = 32'h00100593; // b4: li a1,1
    assign Memory[46] = 32'hfec42503; // b8: lw a0,-20(s0)
    assign Memory[47] = 32'hf69ff0ef; // bc: jal 24 <seriscan>
    assign Memory[48] = 32'hfec42783; // c0: lw a5,-20(s0)
    assign Memory[49] = 32'h0007c783; // c4: lbu a5,0(a5)
    assign Memory[50] = 32'h00078513; // c8: mv a0,a5
    assign Memory[51] = 32'h01c12083; // cc: lw ra,28(sp)
    assign Memory[52] = 32'h01812403; // d0: lw s0,24(sp)
    assign Memory[53] = 32'h02010113; // d4: addi sp,sp,32
    assign Memory[54] = 32'h00008067; // ret

    assign data = Memory[addr[BIT_INDEX:2]];

endmodule