`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2024 09:26:55 PM
// Design Name: 
// Module Name: seg_led
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// The core computing unit 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU_core #(
    parameter BIT_INDEX = 11
    )(
    input CLK,
    input [8:0]key,
    input [3:0]ina,inb,

    //RAM & ROM
    input [31:0]rom_data,
    output [31:0]rom_addr,
    input [31:0]ram_out_data,
    output ram_write_en,
    output [31:0]ram_in_data,
    output [31:0]ram_addr,


    output [31:0]rg_tb[31:0],
    output [31:0]test
    );


    wire [31:0]PC;
    wire [31:0]new_addr;
    wire PC_src;

    PC_register PC_register(
        .clock(CLK),
        ._reset(key[0]),
        .new_addr(new_addr),
        .PC(PC)
    );

    //ROM
    wire [31:0]instruction = rom_data;
    assign rom_addr = PC;


    wire [31:0]imm;
    wire [2:0]ext_op;
    wire reg_write;
    wire [2:0]branch;
    wire mem_to_reg;
    wire mem_write;
    wire [2:0]mem_op;
    wire aluA_src;
    wire [1:0]aluB_src;
    wire [3:0]alu_op;

    wire [4:0]rd;
    wire [4:0]rs1;
    wire [4:0]rs2;

    instr_decoder instr_decoder(
        .instr(instruction),
        .imm(imm),
        .ext_op(ext_op),
        .reg_write(reg_write),
        .branch(branch),
        .mem_to_reg(mem_to_reg),
        .mem_write(mem_write),
        .mem_op(mem_op),
        .aluA_src(aluA_src),
        .aluB_src(aluB_src),
        .alu_op(alu_op),
        .rd(rd),
        .rs1(rs1),
        .rs2(rs2)
    );

    wire [31:0]write_data;
    wire [31:0]rs1_data,rs2_data;

    GP_registers GP_registers(
        .clock(CLK),
        .write_reg(rd & {5{reg_write}}),
        .write_data(write_data),
        .read_regA(rs1),
        .read_regB(rs2),
        .A(rs1_data),
        .B(rs2_data),
        .registers_testbench(rg_tb)
    );

    wire [31:0] aluA_data,aluB_data;

    assign aluA_data = aluA_src ? PC : rs1_data;
    assign aluB_data = aluB_src[1] ? 32'b100 : aluB_src[0] ? imm : rs2_data;

    wire [31:0] ALU_result;
    wire zero,less;

    ALU ALU(
        .A(aluA_data),
        .B(aluB_data),
        .ALU_op(alu_op),
        .result(ALU_result),
        .zero(zero),
        .less(less)
    );

    assign write_data = mem_to_reg ? mem_data : ALU_result;


    //RAM
    wire [31:0]mem_data = ram_out_data;
    assign ram_addr = ALU_result;
    assign ram_in_data = rs2_data;
    assign ram_write_en = mem_write;


    PC_adder PC_adder(
        .clock(CLK),
        .branch(branch),
        .PC(PC),
        .imm(imm),
        .rs1_data(rs1_data),
        .zero(zero),
        .less(less),
        .next_PC(new_addr)
    );

    assign test = rom_addr;


endmodule
