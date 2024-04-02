`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 11:01:28 AM
// Design Name: 
// Module Name: ROM
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


module ROM #(
    parameter BIT_INDEX = 11
    )(
    input clock,
    input [BIT_INDEX:0]addr,
    output [31:0]data
    );
    wire [0:4095][7:0] Memory;
     wire [7:0]data_out0;
          wire [7:0]data_out1;
          wire [7:0]data_out2;
          wire [7:0]data_out3;
          
     DMux4096way8bit DMux4096way8bit_0(Memory, addr, data_out0);
                DMux4096way8bit DMux4096way8bit_1(Memory, addr+2'b000000000001, data_out1);
                DMux4096way8bit DMux4096way8bit_2(Memory, addr+2'b000000000010, data_out2);
                DMux4096way8bit DMux4096way8bit_3(Memory, addr+2'b000000000011, data_out3);
                assign data[31:0]={data_out3,data_out2,data_out1,data_out0};
endmodule
