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
    input _reset,
    input [3:0]ina,inb,

    //cache_data & cache_instruction
    input [31:0]instr_data,
    output [31:0]instr_addr,
    input instr_hit,
    input [31:0]data_out_data,
    output data_write_en,
    output [31:0]data_in_data,
    output [31:0]data_addr,


    output [31:0]rg_tb[31:0],
    output [31:0]test
    );

    wire [31:0]PC;
    wire [31:0]new_real_PC;
    wire [31:0]predict_PC;
    wire [31:0]instruction;
    wire predict_right;

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

    wire [4:0]stage_execute_write_reg;
    wire [31:0]stage_execute_write_data;
    wire [31:0]rs1_data,rs2_data;

    wire [31:0] aluA_data,aluB_data;

    reg [31:0]stage_decode_PC;//记录的是译码阶段输出的PC的值
    reg stage_decode_valid;

    reg [31:0]stage_fetch_PC;//记录的是instruction的PC的值
    reg [31:0]stage_fetch_instruction;
    reg stage_fetch_valid;

    reg [31:0]stage_decode_aluA_data,stage_decode_aluB_data;
    reg [3:0]stage_decode_alu_op;
    reg stage_decode_mem_to_reg;
    reg [2:0]stage_decode_mem_op;
    reg stage_decode_mem_write;
    reg [2:0]stage_decode_branch;
    reg [31:0]stage_decode_imm;
    reg stage_decode_reg_write;
    reg [4:0]stage_decode_rd;
    reg stage_decode_aluA_src;
    reg [1:0] stage_decode_aluB_src;
    reg [4:0] stage_decode_rs1,stage_decode_rs2;

    reg [31:0]stage_execute_PC;//记录的是执行阶段输出的PC的值
    reg stage_execute_valid;

    reg [31:0]stage_execute_aluA_data,stage_execute_aluB_data;
    reg [3:0]stage_execute_alu_op;
    reg stage_execute_mem_to_reg;
    reg [2:0]stage_execute_mem_op;
    reg stage_execute_mem_write;
    reg stage_execute_reg_write;
    reg [4:0]stage_execute_rd;
    reg [31:0]stage_execute_ALU_result;

    reg [31:0]stage_execute_risk_rs2_data;

    wire [31:0] ALU_result;
    wire zero,less;

    reg [31:0]risk_rs1_data,risk_rs2_data;


    PC_register PC_register(
        .clock(CLK),
        ._reset(_reset),
        .predict_PC(predict_PC),
        .new_real_PC(new_real_PC),
        .predict_right(predict_right),
        .PC(PC)
    );

    PC_predictor PC_predictor(
        .clock(CLK),
        .PC(PC),
        .instr_hit(instr_hit),
        .stage_decode_valid(stage_decode_valid),
        .stage_fetch_PC(stage_fetch_PC),
        .new_real_PC(new_real_PC),
        .predict_PC(predict_PC),
        .predict_right(predict_right)
    );

    //ROM / cache_instr
    assign instruction = instr_data;
    assign instr_addr = PC;

    //取指阶段寄存器
    always @(posedge CLK) begin
        if(predict_right && instr_hit && _reset)begin
            stage_fetch_PC <= PC;
            stage_fetch_valid <= 1;
            stage_fetch_instruction <= instruction;
            end
        else begin
            stage_fetch_valid <= 0;
        end
    end

    instr_decoder instr_decoder(
        .instr(stage_fetch_instruction),
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

    //译码阶段寄存器
    always @(posedge CLK) begin
        if(predict_right && _reset)begin
            stage_decode_PC <= stage_fetch_PC;
            stage_decode_valid <= stage_fetch_valid;

            stage_decode_alu_op <= alu_op;
            stage_decode_mem_to_reg <= mem_to_reg;
            stage_decode_mem_op <= mem_op;
            stage_decode_mem_write <= mem_write;
            stage_decode_branch <= branch;
            stage_decode_imm <= imm;
            stage_decode_reg_write <= reg_write;
            stage_decode_rd <= rd;
            stage_decode_aluA_src <= aluA_src;
            stage_decode_aluB_src <= aluB_src;
            stage_decode_rs1 <= rs1;
            stage_decode_rs2 <= rs2;
            end
        else begin
            stage_decode_valid <= 0;
        end
    end

    //在执行段
    GP_registers GP_registers(
        .clock(CLK),
        .write_reg(stage_execute_write_reg),
        .write_data(stage_execute_write_data),
        .read_regA(stage_decode_rs1),
        .read_regB(stage_decode_rs2),
        .A(rs1_data),
        .B(rs2_data),
        .registers_testbench(rg_tb)
    );

    //数据冒险单元
    always @(*) begin
        //当执行端结果输出与译码端结果输出的寄存器相同时，取执行端结果输出的值
        if(stage_decode_rs1 == stage_execute_write_reg && stage_decode_rs1 != 0)begin
            risk_rs1_data <= stage_execute_write_data;
        end
        else risk_rs1_data <= rs1_data;

        
        if(stage_decode_rs2 == stage_execute_write_reg && stage_decode_rs2 != 0)begin
            risk_rs2_data <= stage_execute_write_data;
        end
        else risk_rs2_data <= rs2_data;
    end

    assign aluA_data = stage_decode_aluA_src ? stage_decode_PC : risk_rs1_data;
    assign aluB_data = stage_decode_aluB_src[1] ? 32'b100 : stage_decode_aluB_src[0] ? stage_decode_imm : risk_rs2_data;


    ALU ALU(
        .A(aluA_data),
        .B(aluB_data),
        .ALU_op(stage_decode_alu_op),
        .result(ALU_result),
        .zero(zero),
        .less(less)
    );

    PC_adder PC_adder(
        .clock(CLK),
        .branch(stage_decode_branch),
        .PC(stage_decode_PC),
        .imm(stage_decode_imm),
        .rs1_data(risk_rs1_data),
        .zero(zero),
        .less(less),
        .next_PC(new_real_PC)
    );

    //执行阶段译码器
    always @(posedge CLK) begin
        if(_reset)begin//不需要因为predict_right而清除
            stage_execute_PC <= stage_decode_PC;
            stage_execute_valid <= stage_decode_valid;

            stage_execute_aluA_data <= stage_decode_aluA_data;
            stage_execute_aluB_data <= stage_decode_aluB_data;
            stage_execute_alu_op <= stage_decode_alu_op;
            stage_execute_mem_to_reg <= stage_decode_mem_to_reg;
            stage_execute_mem_op <= stage_decode_mem_op;
            stage_execute_mem_write <= stage_decode_mem_write;
            stage_execute_reg_write <= stage_decode_reg_write;
            stage_execute_rd <= stage_decode_rd;
            stage_execute_ALU_result <= ALU_result;
            stage_execute_risk_rs2_data <= risk_rs2_data;
            end
        else begin
            stage_execute_valid <= 0;
        end
    end

    assign stage_execute_write_reg = stage_execute_rd & {5{stage_execute_reg_write & stage_execute_valid}};

    assign stage_execute_write_data = stage_execute_mem_to_reg ? mem_data : stage_execute_ALU_result;

    //RAM / instr_data
    //lb/lh/lw/lbu/lhu
    //sb/sh/sw
    wire [31:0]mem_data;
    reg [31:0]mem_data_reg;
    reg [31:0]data_in_data_reg;
    
    always @(*)begin
        case(stage_execute_mem_op)
            3'b000:begin
                mem_data_reg = {{24{data_out_data[7]}},data_out_data[7:0]};
            end
            3'b001:begin
                mem_data_reg =  {{16{data_out_data[15]}},data_out_data[15:0]};
            end
            3'b100:begin
                mem_data_reg =  {24'b0,data_out_data[7:0]};
            end
            3'b101:begin
                mem_data_reg =  {16'b0,data_out_data[15:0]};
            end
            default:begin
                mem_data_reg = data_out_data;
            end
        endcase
    end

    always @(*)begin
        case(stage_execute_mem_op)
            3'b000:begin
                data_in_data_reg = {24'b0,stage_execute_risk_rs2_data[7:0]};
            end
            3'b001:begin
                data_in_data_reg = {16'b0,stage_execute_risk_rs2_data[15:0]};
            end
            default:begin
                data_in_data_reg = stage_execute_risk_rs2_data;
            end
        endcase
    end

    assign mem_data = mem_data_reg;
    assign data_addr = stage_execute_ALU_result;
    assign data_in_data = data_in_data_reg;
    assign data_write_en = stage_execute_mem_write && stage_execute_valid;


    assign test = instr_addr;


endmodule
