`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/09 15:25:46
// Design Name: 
// Module Name: ALU_shifter
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


module ALU_Shifter(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALU_op,    // 将 ALU_op 定义为参数
    output reg [31:0] result,
    output zero,
    output less
);
   always@(*)
    begin
        if(ALU_op[2:0]==3'b001) result = B<<A;
        if(ALU_op[3:0]==3'b0101) result = B>>>A;
        if(ALU_op[3:0]==3'b1101) result = B>>A;
    end
    
endmodule
