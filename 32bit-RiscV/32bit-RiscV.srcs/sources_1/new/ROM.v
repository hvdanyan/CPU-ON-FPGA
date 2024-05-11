`timescale 1ns / 1ps

module ROM #(
    parameter BIT_INDEX = 11
    )(
    input clock,
    input [BIT_INDEX:0]addr,
    output [31:0]data
    );

    wire [0:1023]Memory[31:0];
    
    assign Memory[0] = 32'h0;
    assign Memory[1] = 32'h0;
    assign Memory[2] = 32'h0;
    assign Memory[3] = 32'hFFF00113; //li	sp,-1
    assign Memory[4] = 32'h000012b7; //lui	t0,0x1
    assign Memory[5] = 32'hffc28293; //addi	t0,t0,-4
    assign Memory[6] = 32'h00a2a023; //sw   a0,0(t0) 将a0写入到0xffc的位置

    assign Memory[0] = 32'hf9010113; // addi sp,sp,-112
    assign Memory[1] = 32'h06812623; // sw s0,108(sp)
    assign Memory[2] = 32'h07010413; // addi s0,sp,112
    assign Memory[3] = 32'h00100793; // li a5,1
    assign Memory[4] = 32'hf8f42c23; // sw a5,-104(s0)
    assign Memory[5] = 32'h00100793; // li a5,1
    assign Memory[6] = 32'hf8f42e23; // sw a5,-100(s0)
    assign Memory[7] = 32'h00200793; // li a5,2
    assign Memory[8] = 32'hfef42623; // sw a5,-20(s0)
    assign Memory[9] = 32'h0580006f; // j 7c <.L2>
    assign Memory[10] = 32'hfec42783; // lw a5,-20(s0)
    assign Memory[11] = 32'hfff78793; // addi a5,a5,-1
    assign Memory[12] = 32'h00279793; // slli a5,a5,0x2
    assign Memory[13] = 32'hff078793; // addi a5,a5,-16
    assign Memory[14] = 32'h008787b3; // add a5,a5,s0
    assign Memory[15] = 32'hfa87a703; // lw a4,-88(a5)
    assign Memory[16] = 32'hfec42783; // lw a5,-20(s0)
    assign Memory[17] = 32'hffe78793; // addi a5,a5,-2
    assign Memory[18] = 32'h00279793; // slli a5,a5,0x2
    assign Memory[19] = 32'hff078793; // addi a5,a5,-16
    assign Memory[20] = 32'h008787b3; // add a5,a5,s0
    assign Memory[21] = 32'hfa87a783; // lw a5,-88(a5)
    assign Memory[22] = 32'h00f70733; // add a4,a4,a5
    assign Memory[23] = 32'hfec42783; // lw a5,-20(s0)
    assign Memory[24] = 32'h00279793; // slli a5,a5,0x2
    assign Memory[25] = 32'hff078793; // addi a5,a5,-16
    assign Memory[26] = 32'h008787b3; // add a5,a5,s0
    assign Memory[27] = 32'hfae7a423; // sw a4,-88(a5)
    assign Memory[28] = 32'hfec42783; // lw a5,-20(s0)
    assign Memory[29] = 32'h00178793; // addi a5,a5,1
    assign Memory[30] = 32'hfef42623; // sw a5,-20(s0)
    assign Memory[31] = 32'hfec42703; // lw a4,-20(s0)
    assign Memory[32] = 32'h01300793; // li a5,19
    assign Memory[33] = 32'hfae7d2e3; // bge a5,a4,28 <.L3>
    assign Memory[34] = 32'hfe442783; // lw a5,-28(s0)
    assign Memory[35] = 32'hfef42423; // sw a5,-24(s0)
    assign Memory[36] = 32'h00000793; // li a5,0
    assign Memory[37] = 32'h00078513; // mv a0,a5
    assign Memory[38] = 32'h06c12403; // lw s0,108(sp)
    assign Memory[39] = 32'h07010113; // addi sp,sp,112
    assign Memory[40] = 32'h00008067; // ret

    assign data = Memory[addr[BIT_INDEX:2]];

endmodule
