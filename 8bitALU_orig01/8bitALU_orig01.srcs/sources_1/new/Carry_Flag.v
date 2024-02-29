`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/24 10:19:28
// Design Name: 
// Module Name: Carry_Flag
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



module Carry_Flag(
    input CLK, 
    input [7:0]Reg_a, Reg_b,Reg_output,
    input ARisk,BRisk,
    input Rm,
    input [2:0]opcode,
    output reg Reg_carry
    );

    reg[7:0]C;

    always@(posedge CLK)begin
        if(Rm == 1 & opcode == 3'b110) {Reg_carry, C} <= (ARisk == 1) ? Reg_output + Reg_b + Reg_carry: (BRisk == 1) ? Reg_a + Reg_output + Reg_carry: Reg_a + Reg_b + Reg_carry;// forget to change 010 to 110 && also risks && it should be 3'b110 not 110.
        else Reg_carry<=Reg_carry;
    end

    initial
    begin
        Reg_carry = 0;
    end
endmodule

