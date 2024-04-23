`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/09 15:31:04
// Design Name: 
// Module Name: ALU_logic
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


module ALU_Logic(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALU_op,    // 将 ALU_op 定义为参数
    output reg [31:0] result,
    output zero,
    output less
    );
    always@(*)
    begin
            if(ALU_op[2:0]==3'b110) result = B||A;
            if(ALU_op[2:0]==3'b111) result = B&&A;
            if(ALU_op[2:0]==3'b100) result = B^A;
    end
        
endmodule
