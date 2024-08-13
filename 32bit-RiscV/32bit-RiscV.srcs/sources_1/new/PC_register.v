`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 10:47:36 AM
// Design Name: 
// Module Name: PC_register
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


module PC_register(
    input clock,
    input _reset,
    input [31:0]predict_PC,
    input [31:0]new_real_PC,//差2个时钟周期
    input predict_right,
    output [31:0]PC
    );

    reg [31:0]PC_reg;

    always @(posedge clock or negedge _reset) begin
        if (_reset == 32'b0) begin
            PC_reg <= 0;
        end
        else if(predict_right)begin
            PC_reg <= predict_PC;
        end
        else begin
            PC_reg <= new_real_PC;
        end
    end

    assign PC = PC_reg;

    initial
    begin
        PC_reg = 0;
    end
endmodule
