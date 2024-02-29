`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/16 10:14:17
// Design Name: 
// Module Name: instruction_execute
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


module instruction_execute(
    input CLK,
    input [2:0]opcode,
    input [7:0]Reg_a,Reg_b,RamM,regBtransmit,

    input PCwrite,
    input Awrite,Bwrite,Mwrite, //write enable
    output reg Awrite_delay,Bwrite_delay,Mwrite_delay,
    
    output [7:0]Reg_output,
    output [7:0] ALUout
    //output Carry
    );
    wire Carry,Rm;

    assign Rm = regBtransmit[7];
    //wirte(2) registor
    always@(posedge CLK)
    begin
        Awrite_delay <= ~PCwrite&Awrite;
        Bwrite_delay <= ~PCwrite&Bwrite;
        Mwrite_delay <= ~PCwrite&Mwrite;
    end
    
    ALU ALU_inst(Awrite_delay,Bwrite_delay,Mwrite_delay,opcode[2:0],Reg_a,Reg_b,RamM,Reg_output,Carry,ALUout);//ESP:replace XRisk by Xwrite_delay
    outputregister outputregister_inst(CLK ,ALUout,regBtransmit, Reg_output);
    Carry_Flag Carry_Flag_inst(
        .CLK(CLK),
        .Reg_a(Reg_a),
        .Reg_b(Reg_b),
        .Reg_output(Reg_output),
        .ARisk(Awrite_delay),
        .BRisk(Bwrite_delay), 
        .Rm(Rm),
        .opcode(opcode[2:0]),
        .Reg_carry(Carry)
        );

endmodule
