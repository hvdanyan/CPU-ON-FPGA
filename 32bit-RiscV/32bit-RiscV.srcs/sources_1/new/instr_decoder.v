`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 11:10:39 AM
// Design Name: 
// Module Name: instr_decoder
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
//Reference:https://nju-projectn.github.io/dlco-lecture-note/exp/11.html

module instr_decoder (
    input clock,
    input [31:0]instr,

    output [31:0]imm,
    output [2:0]ext_op,
    output reg_write,
    output [2:0]branch,
    output mem_to_reg,
    output mem_write,
    output [1:0]mem_op,
    output aluA_src,
    output [1:0]aluB_src,
    output [2:0]alu_op,

    output [4:0]rd,
    output [4:0]rs1,
    output [4:0]rs2
    );

    wire [6:0] opcode;
    wire [4:0] rd;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [2:0] funct3;
    wire [6:0] funct7;
    wire [31:0] immI, immS, immB, immU, immJ;

    assign opcode = instr[6:0];
    assign rd = instr[11:7];
    assign rs1 = instr[19:15];
    assign rs2 = instr[24:20];
    assign funct3 = instr[14:12];
    assign funct7 = instr[31:25];
    assign immI = { {20{instr[31]}}, instr[31:20] };
    assign immS = { {20{instr[31]}}, instr[31:25], instr[11:7] };
    assign immB = { {20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
    assign immU = { instr[31:12], 12'b0 };
    assign immJ = { {12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0 };

endmodule
