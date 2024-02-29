`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/07 12:55:01
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

//When Arisk==1,Reg_a will be replaced by Reg_output, so do Reg_b and RamM
module ALU(
input ARisk,BRisk,MRisk,
input [2:0]opcode,
input [7:0]Reg_a,Reg_b,RamM,Reg_output,
input Carry,
output reg [7:0]ALUout//delete "sign"
    );
    wire [7:0] sum;
    always@(*)
        case(opcode)
            3'b000:ALUout = (BRisk == 1) ? Reg_output : Reg_b; // R1
            3'b001:ALUout = (BRisk == 1) ? ~Reg_output + 1'b1 : ~Reg_b + 1'b1; // -R1
            3'b010:ALUout = (ARisk == 1) ? Reg_output + Reg_b: (BRisk == 1) ? Reg_a + Reg_output: Reg_a + Reg_b; // R0+R1
            3'b011:ALUout = (ARisk == 1) ? Reg_output : Reg_a; // R0
            3'b100:ALUout = (MRisk == 1) ? Reg_output : RamM;
            3'b101:ALUout = (ARisk == 1) ? !Reg_output : !Reg_a;
            3'b110:ALUout = (ARisk == 1) ? Reg_output + Reg_b + Carry: (BRisk == 1) ? Reg_a + Reg_output + Carry: Reg_a + Reg_b + Carry; // R0+R1+Carry
            3'b111:ALUout = (ARisk == 1) ? Reg_output ^ Reg_b : (BRisk == 1) ? Reg_a ^ Reg_output : Reg_a ^ Reg_b; //R0^R1(XOR)
        endcase
endmodule

