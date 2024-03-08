`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/28 21:18:00
// Design Name: 
// Module Name: outputregister
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// The outputregister module acts as a register that selects between the values of regBtransmit and ALUout based on the MSB of regBtransmit. 
// In the 8 bit cpu, it is used to delay the transmission for a clock cycle and transmit the value of regBtransmit or ALUout to REG_output.
// The input ports are CLK, a clock signal, ALUout,and regBtransmit。
// The output port is Reg_output
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module outputregister(
    input CLK,
    input [7:0]ALUout,
    input [7:0]regBtransmit,
    output reg [7:0] Reg_output// forget reg& it's an array.:(
    );
    always @(posedge CLK ) 
    begin
        if(regBtransmit[7] == 0)Reg_output <= regBtransmit;
        else Reg_output <= ALUout;
        //Reg_output <= 8'b11111111;
    end
endmodule
