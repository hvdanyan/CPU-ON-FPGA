`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/08 11:14:14
// Design Name: 
// Module Name: PCregister
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// The input ports of the module are CLK,write,activate,dp_jump,PCtraceback, PROGRAM1,PROGRAM2, Bytein, BTA. The output ports are Byteout and PC_delay.
// The PCregister stores the value of the instruction that is now operated, which helps to control the operation of the cpu.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PCregister(
    input CLK,write,activate,dp_jump,PCtraceback,//here dp_jump is CS[1]
    input PROGRAM1,PROGRAM2,
    input [7:0] Bytein,BTA,
    output [7:0] Byteout,
    output reg [2:0][7:0]PC_delay
    );
    reg [7:0]ByteMemo;
    
    always@(posedge CLK)
    begin
    PC_delay[0] <= ByteMemo;
    PC_delay[1] <= PC_delay[0];
    PC_delay[2] <= PC_delay[1];
    if(PROGRAM1 == 1)ByteMemo <= 8'b00000000;
    else if(PROGRAM2 == 1)ByteMemo <= 8'b01000011;
    else if(activate&dp_jump)ByteMemo <= BTA;//Dynamic predict
    else if(PCtraceback)ByteMemo <= PC_delay[2]+8'b1;
    else if(write == 1)ByteMemo <= Bytein;
    else ByteMemo <= ByteMemo+8'b00000001;
    end
    
    assign Byteout = ByteMemo;
endmodule
