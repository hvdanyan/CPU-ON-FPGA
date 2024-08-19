`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/13/2024 05:29:34 PM
// Design Name: 
// Module Name: PC_predictor
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


module PC_predictor(
    input clock,
    input [31:0] PC,
    input instr_hit,
    input stage_decode_valid,
    input [31:0] stage_fetch_PC,//因为new_real_PC在译码端输出后立即输出，所以是stage_decode_PC的下一条指令，因此应该和stage_fetch_PC作对比。
    input [31:0] new_real_PC,
    output [31:0] predict_PC,
    output predict_right
    );    

    assign predict_PC = instr_hit ? PC + 4 : PC;//这个是组合电路，保证下一个PC寄存器立即更新
    assign predict_right = stage_decode_valid ? (stage_fetch_PC == new_real_PC) : 1;//PC_adder的时序是在执行阶段。



endmodule
