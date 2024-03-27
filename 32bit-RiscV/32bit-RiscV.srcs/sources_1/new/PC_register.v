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
    input [31:0]new_addr,
    output [31:0]PC
    );

    reg [31:0]PC_reg;

    always @(posedge clock) begin
        if (_reset == 0) begin
            PC_reg <= 0;
        end
        else
        PC_reg <= new_addr;
    end

    assign PC = PC_reg;
endmodule
