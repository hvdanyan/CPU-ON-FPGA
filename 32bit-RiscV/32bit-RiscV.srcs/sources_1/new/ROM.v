`timescale 1ns / 1ps

module ROM #(
    parameter BIT_INDEX = 11
    )(
    input clock,
    input [BIT_INDEX:0]addr,
    output [31:0]data
    );

    wire [31:0]Memory[0:1023];
    
    assign Memory[0] = 32'h0;
    assign Memory[1] = 32'h0;
    assign Memory[2] = 32'h0;
    assign Memory[3] = 32'hFFF00113; //li	sp,-1
    assign Memory[4] = 32'h000012b7; //lui	t0,0x1
    assign Memory[5] = 32'hffc28293; //addi	t0,t0,-4
    assign Memory[6] = 32'h00a2a023; //sw   a0,0(t0) 将a0写入到0xffc的位置

    assign Memory[7] = 32'h00002197; // auipc gp,0x2
    assign Memory[8] = 32'h75418193; // addi
    assign Memory[9] = 32'hd5418513; // addi
    assign Memory[10] = 32'hd7018613; // addi
    assign Memory[11] = 32'h40a60633; // sub a2,a2,a0
    assign Memory[12] = 32'h00000593; // li a1,0
    assign Memory[13] = 32'h0; // jal 170 <memset>
    assign Memory[14] = 32'h00001517; // auipc a0,0x1
    assign Memory[15] = 32'hbd850513; // addi
    assign Memory[16] = 32'h00050863; // beqz a0,50 <_start+0x34>
    assign Memory[17] = 32'h00002517; // auipc a0,0x2
    assign Memory[18] = 32'hc8050513; // addi
    assign Memory[19] = 32'h3c5000ef; // jal c10 <atexit>
    assign Memory[20] = 32'h0; // jal a38 <__libc_init_array>
    assign Memory[21] = 32'h00012503; // lw a0,0(sp)
    assign Memory[22] = 32'h00410593; // addi a1,sp,4
    assign Memory[23] = 32'h00000613; // li a2,0
    assign Memory[24] = 32'h06c000ef; // jal cc <main>
    assign Memory[25] = 32'h1e80006f; // j 24c <exit>
    assign Memory[26] = 32'hff010113; // addi sp,sp,-16
    assign Memory[27] = 32'h00812423; // sw s0,8(sp)
    assign Memory[28] = 32'hd541c783; // lbu
    assign Memory[29] = 32'h00112623; // sw ra,12(sp)
    assign Memory[30] = 32'h02079263; // bnez a5,9c <__do_global_dtors_aux+0x34>
    assign Memory[31] = 32'h00000793; // li a5,0
    assign Memory[32] = 32'h00078a63; // beqz a5,94 <__do_global_dtors_aux+0x2c>
    assign Memory[33] = 32'h00002537; // lui a0,0x2
    assign Memory[34] = 32'hf7050513; // addi
    assign Memory[35] = 32'h00000097; // auipc ra,0x0
    assign Memory[36] = 32'h000000e7; // jalr
    assign Memory[37] = 32'h00100793; // li a5,1
    assign Memory[38] = 32'hd4f18a23; // sb
    assign Memory[39] = 32'h00c12083; // lw ra,12(sp)
    assign Memory[40] = 32'h00812403; // lw s0,8(sp)
    assign Memory[41] = 32'h01010113; // addi sp,sp,16
    assign Memory[42] = 32'h00008067; // ret
    assign Memory[43] = 32'h00000793; // li a5,0
    assign Memory[44] = 32'h00078c63; // beqz a5,c8 <frame_dummy+0x1c>
    assign Memory[45] = 32'h00002537; // lui a0,0x2
    assign Memory[46] = 32'hd5818593; // addi
    assign Memory[47] = 32'hf7050513; // addi
    assign Memory[48] = 32'h00000317; // auipc t1,0x0
    assign Memory[49] = 32'h00000067; // jr
    assign Memory[50] = 32'h00008067; // ret
    assign Memory[51] = 32'hf9010113; // addi sp,sp,-112
    assign Memory[52] = 32'h06812623; // sw s0,108(sp)
    assign Memory[53] = 32'h07010413; // addi s0,sp,112
    assign Memory[54] = 32'h00100793; // li a5,1
    assign Memory[55] = 32'hf8f42c23; // sw a5,-104(s0)
    assign Memory[56] = 32'h00100793; // li a5,1
    assign Memory[57] = 32'hf8f42e23; // sw a5,-100(s0)
    assign Memory[58] = 32'h00200793; // li a5,2
    assign Memory[59] = 32'hfef42623; // sw a5,-20(s0)
    assign Memory[60] = 32'h0580006f; // j 148 <main+0x7c>
    assign Memory[61] = 32'hfec42783; // lw a5,-20(s0)
    assign Memory[62] = 32'hfff78793; // addi a5,a5,-1
    assign Memory[63] = 32'h00279793; // slli a5,a5,0x2
    assign Memory[64] = 32'hff078793; // addi a5,a5,-16
    assign Memory[65] = 32'h008787b3; // add a5,a5,s0
    assign Memory[66] = 32'hfa87a703; // lw a4,-88(a5)
    assign Memory[67] = 32'hfec42783; // lw a5,-20(s0)
    assign Memory[68] = 32'hffe78793; // addi a5,a5,-2
    assign Memory[69] = 32'h00279793; // slli a5,a5,0x2
    assign Memory[70] = 32'hff078793; // addi a5,a5,-16
    assign Memory[71] = 32'h008787b3; // add a5,a5,s0
    assign Memory[72] = 32'hfa87a783; // lw a5,-88(a5)
    assign Memory[73] = 32'h00f70733; // add a4,a4,a5
    assign Memory[74] = 32'hfec42783; // lw a5,-20(s0)
    assign Memory[75] = 32'h00279793; // slli a5,a5,0x2
    assign Memory[76] = 32'hff078793; // addi a5,a5,-16
    assign Memory[77] = 32'h008787b3; // add a5,a5,s0
    assign Memory[78] = 32'hfae7a423; // sw a4,-88(a5)
    assign Memory[79] = 32'hfec42783; // lw a5,-20(s0)
    assign Memory[80] = 32'h00178793; // addi a5,a5,1
    assign Memory[81] = 32'hfef42623; // sw a5,-20(s0)
    assign Memory[82] = 32'hfec42703; // lw a4,-20(s0)
    assign Memory[83] = 32'h01300793; // li a5,19
    assign Memory[84] = 32'hfae7d2e3; // bge a5,a4,f4 <main+0x28>
    assign Memory[85] = 32'hfe442783; // lw a5,-28(s0)
    assign Memory[86] = 32'hfef42423; // sw a5,-24(s0)
    assign Memory[87] = 32'h00000793; // li a5,0
    assign Memory[88] = 32'h00078513; // mv a0,a5
    assign Memory[89] = 32'h06c12403; // lw s0,108(sp)
    assign Memory[90] = 32'h07010113; // addi sp,sp,112
    assign Memory[91] = 32'h00008067; // ret


    assign data = Memory[addr[BIT_INDEX:2]];

endmodule
