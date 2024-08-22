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
    input data_hit,


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

    wire [4:0] write_reg;
    wire [31:0]write_data;
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

    reg [4:0]stage_execute_write_reg;

    wire [31:0] ALU_result;
    wire zero,less;

    reg [31:0]risk_rs1_data,risk_rs2_data;

    reg stage_memory_valid;
    reg [31:0]stage_memory_write_data;
    reg [4:0]stage_memory_write_reg;


    PC_register PC_register(
        .clock(CLK),
        ._reset(_reset),
        .predict_PC(predict_PC),
        .new_real_PC(new_real_PC),
        .predict_right(predict_right),
        ._risk_data_hazard(_risk_data_hazard),
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
        if(predict_right && instr_hit && _reset && _risk_data_hazard)begin
            stage_fetch_PC <= PC;
            stage_fetch_valid <= 1;
            stage_fetch_instruction <= instruction;
            end
        else if (!_risk_data_hazard) begin
            //不做任何变化
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
        if(predict_right && _reset && _risk_data_hazard)begin
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
        else if(!_risk_data_hazard)begin
            //不做任何变化
        end
        else begin
            stage_decode_valid <= 0;
        end
    end

    //在执行段
    GP_registers GP_registers(
        .clock(CLK),
        .write_reg(stage_memory_valid ? stage_memory_write_reg : 5'b0),
        .write_data(stage_memory_write_data),
        .read_regA(stage_decode_rs1),
        .read_regB(stage_decode_rs2),
        .A(rs1_data),
        .B(rs2_data),
        .registers_testbench(rg_tb)
    );

    //数据冒险单元
    wire _risk_data_hazard;
    wire _risk_execute_mem;
    reg _risk_data_hazard_reg;

    wire risk_rs1_execute = (stage_decode_rs1 == stage_execute_write_reg && stage_decode_rs1 != 0 && stage_execute_valid && _risk_data_hazard_reg);//判断rs1是否和execute输出存在冒险
    wire risk_rs2_execute = (stage_decode_rs2 == stage_execute_write_reg && stage_decode_rs2 != 0 && stage_execute_valid && _risk_data_hazard_reg);//判断rs2是否和execute输出存在冒险

    wire risk_rs1_memory = (stage_decode_rs1 == stage_memory_write_reg && stage_decode_rs1 != 0 && stage_memory_valid);//判断rs1是否和memory输出存在冒险
    wire risk_rs2_memory = (stage_decode_rs2 == stage_memory_write_reg && stage_decode_rs2 != 0 && stage_memory_valid);//判断rs2是否和memory输出存在冒险

    assign _risk_data_hazard = _risk_execute_mem && data_hit;
    assign _risk_execute_mem = !((risk_rs1_execute && stage_execute_mem_to_reg) || (risk_rs2_execute && stage_execute_mem_to_reg));//在执行阶段出现的冒险行为，并且需要在mem阶段处理,那么需要堵塞PC、取指、译码、执行，但是不要影响访存单元;如果_risk_data_hazard_reg为0，表示执行阶段正在被堵塞，意味着执行单元的输出无效，就不要考虑执行单元输出寄存器的冒险。（否则CPU会因为冒险而卡死）

    always @(*) begin
        //当执行端结果输出与译码端结果输出的寄存器相同时，取执行端结果输出的值
        if(risk_rs1_execute)begin
            if(!stage_execute_mem_to_reg)begin
            risk_rs1_data <= stage_execute_ALU_result;
            end
            //另一种情况，取内存端结果输出的值，需要堵塞至少一个时钟周期，所以_risk_execute_mem会被设置为0，从而导致_risk_data_hazard被设置为0，从而实现了堵塞各个单元。
        end
        else if(risk_rs1_memory)begin
            risk_rs1_data <= stage_memory_write_data;
        end
        else begin
        risk_rs1_data <= rs1_data;
        end

        if(risk_rs2_execute)begin
            if(!stage_execute_mem_to_reg)begin
            risk_rs2_data <= stage_execute_ALU_result;
            end
        end
        else if(risk_rs2_memory)begin
            risk_rs2_data <= stage_memory_write_data;
        end
        else begin
        risk_rs2_data <= rs2_data;
        end
    end

    assign aluA_data = stage_decode_aluA_src ? stage_decode_PC : risk_rs1_data;
    assign aluB_data = stage_decode_aluB_src[1] ? 32'b100 : stage_decode_aluB_src[0] ? stage_decode_imm : risk_rs2_data;

    //写入寄存器的编号
    assign write_reg = stage_decode_rd & {5{stage_decode_reg_write}};

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
        if(_reset && _risk_data_hazard)begin//不需要因为predict_right而清除
            stage_execute_PC <= stage_decode_PC;
            stage_execute_valid <= stage_decode_valid;
            _risk_data_hazard_reg <= 1;

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
            stage_execute_write_reg <= write_reg;
        end
        else if (!_risk_data_hazard)begin
            _risk_data_hazard_reg <= 0;
            //不做任何变化
        end
        else begin
            stage_execute_valid <= 0;
        end
    end

    assign write_data = stage_execute_mem_to_reg ? mem_data : stage_execute_ALU_result;

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

    //访存阶段译码器
    always @(posedge CLK) begin
        if(_reset && data_hit)begin
            stage_memory_valid <= stage_execute_valid;

            stage_memory_write_data <= write_data;
            stage_memory_write_reg <= stage_execute_write_reg;

        end
        else if (!data_hit)begin
            //不做任何变化
        end
        else begin
            stage_memory_valid <= 0;
        end
    end


    assign test = instr_addr;


endmodule
