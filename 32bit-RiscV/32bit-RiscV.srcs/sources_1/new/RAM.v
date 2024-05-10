`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 12:48:47 PM
// Design Name: 
// Module Name: RAM
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


module RAM #(
    parameter BIT_INDEX = 11
    )(
    input clock,
    input [BIT_INDEX:0]addr,
    input [31:0]data_in,
    input write_en,
    output [31:0]data_out,
    output [23:0]print_data1,
    output [23:0]print_data2
     );

    reg [7:0]Memory[0:4095];// Another syntax is [0:4095][7:0]Memory

    always @(posedge clock) begin
        if(write_en) begin
            {Memory[{addr[BIT_INDEX:2],2'b11}],Memory[{addr[BIT_INDEX:2],2'b10}],Memory[{addr[BIT_INDEX:2],2'b01}],Memory[{addr[BIT_INDEX:2],2'b00}]} <= data_in;
        end
    end

    assign data_out = {Memory[{addr[BIT_INDEX:2],2'b11}],Memory[{addr[BIT_INDEX:2],2'b10}],Memory[{addr[BIT_INDEX:2],2'b01}],Memory[{addr[BIT_INDEX:2],2'b00}]};

    assign print_data1 = {Memory[12'h7ffe],Memory[12'h7ffd],Memory[12'h7ffc]};
    assign print_data2 = {16'b0,Memory[12'h7fff]};
    
    initial
    begin
        for(int i=0;i<4096;i=i+1)
        begin
            Memory[i] = 32'b0;
        end
    end

endmodule

