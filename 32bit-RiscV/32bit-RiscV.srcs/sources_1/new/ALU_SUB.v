`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/03 17:28:01
// Design Name: 
// Module Name: ALU_SUB
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


module ALU_Sub(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALU_op,    // 将 ALU_op 定义为参数,
    output reg [31:0] result,
    output zero,
    output less
);
    always@(*)
    begin
        result = A - B;;
    end
    assign less = result > 0 ? B : A;
endmodule
