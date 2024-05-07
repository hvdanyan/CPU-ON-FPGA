`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 01:10:58 PM
// Design Name: 
// Module Name: PC_adder
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


module PC_adder(
    input clock,
    input [2:0]branch,
    input [31:0]PC,
    input [31:0]imm,
    input [31:0]rs1_data,
    input zero,less,
    output [31:0]next_PC
    );

    reg next_PC_reg;

    always @(*) begin
        case(branch)
            3'b000: next_PC_reg = PC + 4;
            3'b001: next_PC_reg = PC + imm;
            3'b010: next_PC_reg = PC + rs1_data;
            3'b100: next_PC_reg = zero ? PC + imm : PC + 4;
            3'b101: next_PC_reg = ~zero ? PC + imm : PC + 4;
            3'b110: next_PC_reg = less ? PC + imm : PC + 4;
            3'b111: next_PC_reg = ~less ? PC + imm : PC + 4;
            default: next_PC_reg = PC + 4;
        endcase
    end

    assign next_PC = next_PC_reg;

endmodule
