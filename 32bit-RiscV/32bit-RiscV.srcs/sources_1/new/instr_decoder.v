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
    input [31:0]instr,

    output [31:0]imm, // immediate value
    output [2:0]ext_op, // 000:immI, 001:immU, 010:immS, 011:immB, 100:immJ
    output reg_write, // 1:write, 0:not write
    output [2:0]branch, // 000:not branch, 001:jmp_PC, 010:jmp_reg, 011:(NOT EXIST), 100:beq, 101:bne, 110:blt, 111:bge
    output mem_to_reg, // 1:rd = mem, 0:rd = alu
    output mem_write, // 1:write, 0:not write
    output [2:0]mem_op, // Not available at present
    output aluA_src, // 0:rs1, 1:PC
    output [1:0]aluB_src, // 00:rs2, 01:imm, 1x:4
    output [3:0]alu_op, // 0000:add, 1001:sub, x001:sll, 0010: slti, 1010:sltiu, x011:srcB, x100:xor, 0101:srl, 1101:sra, 1100:or, 1110:and 

    output [4:0]rd,
    output [4:0]rs1,
    output [4:0]rs2
    );

    wire [6:0] opcode;
    //wire [4:0] rd;
    //wire [4:0] rs1;
    //wire [4:0] rs2;
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

    reg [31:0] imm_reg;
    reg [2:0] ext_op_reg;
    reg reg_write_reg;
    reg [2:0] branch_reg;
    reg mem_to_reg_reg;
    reg mem_write_reg;
    reg [2:0] mem_op_reg;
    reg aluA_src_reg;
    reg [1:0] aluB_src_reg;
    reg [2:0] alu_op_reg;

    always @(*) begin
        case(opcode[6:2])
            5'b00100: begin
                imm_reg <= immI;
                ext_op_reg <= 3'b000;
                reg_write_reg <= 1'b1;
                branch_reg <= 3'b000;
                mem_to_reg_reg <= 1'b0;
                mem_write_reg <= 1'b0;
                aluA_src_reg <= 1'b0;
                aluB_src_reg <= 2'b01;
                case(funct3)
                    3'b000: alu_op_reg <= 4'b0000;
                    3'b001: alu_op_reg <= 4'b0001;
                    3'b010: alu_op_reg <= 4'b0010;
                    3'b011: alu_op_reg <= 4'b1010;
                    3'b100: alu_op_reg <= 4'b0100;
                    3'b101: if(funct7[5] == 1'b0) alu_op_reg <= 4'b0101;
                            else alu_op_reg <= 4'b1101;
                    3'b110: alu_op_reg <= 4'b0110;
                    3'b111: alu_op_reg <= 4'b0111;
                endcase
            end
            5'b00000: begin
                imm_reg <= immI;
                ext_op_reg <= 3'b000;
                reg_write_reg <= 1'b1;
                branch_reg <= 3'b000;
                mem_to_reg_reg <= 1'b1;
                mem_write_reg <= 1'b0;
                mem_op_reg <= 3'bxxx;
                aluA_src_reg <= 1'b0;
                aluB_src_reg <= 2'b01;
                alu_op_reg <= 4'b0000;
            end
            5'b11001: begin
                imm_reg <= immI;
                ext_op_reg <= 3'b000;
                reg_write_reg <= 1'b1;
                branch_reg <= 3'b010;
                mem_to_reg_reg <= 1'b0;
                mem_write_reg <= 1'b0;
                mem_op_reg <= 3'bxxx;
                aluA_src_reg <= 1'b1;
                aluB_src_reg <= 2'b10;
                alu_op_reg <= 4'b0000;
            end
            5'b01101:begin
                imm_reg <= immU;
                ext_op_reg <= 3'b001;
                reg_write_reg <= 1'b1;
                branch_reg <= 3'b000;
                mem_to_reg_reg <= 1'b0;
                mem_write_reg <= 1'b0;
                mem_op_reg <= 3'bxxx;
                aluA_src_reg <= 1'bx;
                aluB_src_reg <= 2'b01;
                alu_op_reg <= 4'b0011;
            end
            5'b00101: begin
                imm_reg <= immU;
                ext_op_reg <= 3'b001;
                reg_write_reg <= 1'b1;
                branch_reg <= 3'b000;
                mem_to_reg_reg <= 1'b0;
                mem_write_reg <= 1'b0;
                mem_op_reg <= 3'bxxx;
                aluA_src_reg <= 1'b1;
                aluB_src_reg <= 2'b01;
                alu_op_reg <= 4'b0000;
            end
            5'b01000: begin
                imm_reg <= immS;
                ext_op_reg <= 3'b010;
                reg_write_reg <= 1'b0;
                branch_reg <= 3'b000;
                mem_to_reg_reg <= 1'bx;
                mem_write_reg <= 1'b1;
                mem_op_reg <= funct3;
                aluA_src_reg <= 1'b0;
                aluB_src_reg <= 2'b01;
                alu_op_reg <= 4'b0000;
            end
            5'b11000: begin
                imm_reg <= immB;
                ext_op_reg <= 3'b011;
                reg_write_reg <= 1'b0;
                case(funct3)
                    3'b000: branch_reg <= 3'b100;
                    3'b001: branch_reg <= 3'b101;
                    3'b100: branch_reg <= 3'b110;
                    3'b101: branch_reg <= 3'b111;
                    default: branch_reg <= funct3;
                endcase
                mem_to_reg_reg <= 1'bx;
                mem_write_reg <= 1'b0;
                mem_op_reg <= 3'bxxx;
                aluA_src_reg <= 1'b0;
                aluB_src_reg <= 2'b00;
                if(funct3[2:1] == 2'b11) alu_op_reg <= 4'b1010;
                else alu_op_reg <= 4'b0010;
            end
            5'b11011: begin
                imm_reg <= immJ;
                ext_op_reg <= 3'b100;
                reg_write_reg <= 1'b1;
                branch_reg <= 3'b001;
                mem_to_reg_reg <= 1'b0;
                mem_write_reg <= 1'b0;
                mem_op_reg <= 3'bxxx;
                aluA_src_reg <= 1'b1;
                aluB_src_reg <= 2'b10;
                alu_op_reg <= 4'b0000;
            end
            default: begin // 5'b01100
                imm_reg <= 32'b0;
                ext_op_reg <= 3'bxxx;
                reg_write_reg <= 1'b1;
                branch_reg <= 3'b000;
                mem_to_reg_reg <= 1'b0;
                mem_write_reg <= 1'b0;
                mem_op_reg <= 3'bxxx;
                aluA_src_reg <= 1'b0;
                aluB_src_reg <= 2'b00;
                case(funct3)
                    3'b000: if(funct7[5] == 1'b0) alu_op_reg <= 4'b0000;
                            else alu_op_reg <= 4'b1000;
                    3'b001: alu_op_reg <= 4'b0001;
                    3'b010: alu_op_reg <= 4'b0010;
                    3'b011: alu_op_reg <= 4'b1010;
                    3'b100: alu_op_reg <= 4'b0100;
                    3'b101: if(funct7[5] == 1'b0) alu_op_reg <= 4'b0101;
                            else alu_op_reg <= 4'b1101;
                    3'b110: alu_op_reg <= 4'b0110;
                    3'b111: alu_op_reg <= 4'b0111;
                endcase
            end
        endcase
    end

    assign imm = imm_reg;
    assign ext_op = ext_op_reg;
    assign reg_write = reg_write_reg;
    assign branch = branch_reg;
    assign mem_to_reg = mem_to_reg_reg;
    assign mem_write = mem_write_reg;
    assign mem_op = mem_op_reg;
    assign aluA_src = aluA_src_reg;
    assign aluB_src = aluB_src_reg;
    assign alu_op = alu_op_reg;
            

endmodule
