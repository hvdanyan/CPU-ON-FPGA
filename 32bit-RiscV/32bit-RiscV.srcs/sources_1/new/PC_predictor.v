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
    input _reset,
    input [31:0] new_real_PC,
    output [31:0] predict_PC,
    output predict_right
    );

    wire predict_right;
    reg [31:0]predict_PC_1ck;
    reg [31:0]predict_PC_2ck;

    assign predict_right = predict_PC_2ck == new_real_PC;

    
endmodule
