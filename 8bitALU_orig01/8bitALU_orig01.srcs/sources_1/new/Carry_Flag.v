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



module Carry_Flag(input [7:0]Reg_a, Reg_b,input [2:0]opcode,input CLK,  output reg Reg_carry);
    //reg cout;
    reg[7:0]C;
    always@(posedge CLK)begin
        if(opcode == 010) begin 
            {Reg_carry, C} = Reg_a + Reg_b + Reg_carry;
                    //Reg_carry = Reg_carry;      //½øÎ»
        end
        else Reg_carry<=Reg_carry;
    end
endmodule

