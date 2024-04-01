`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 11:36:24 AM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input clock,
    input [31:0]A,B,
    input [3:0]ALU_op,
    output [31:0]result,
    output zero, less  // 添加逗号分隔符
);
    wire [31:0] result_temp;
    wire zero_temp;
    wire less_temp;
    
    always @(posedge clock) begin
        if (ALU_op == 3'b0000)
            ALU_ADD  ALU_ADD_inst(
            A,
            B,
            result_temp,
            zero_temp,
            less_temp);
    end
    
    assign result = result_temp;  // 将result_temp赋给result输出端口
    assign zero = zero_temp;
    assign less = less_temp;
    
endmodule
