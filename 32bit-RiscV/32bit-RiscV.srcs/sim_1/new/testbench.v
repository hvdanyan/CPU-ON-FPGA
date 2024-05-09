`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2024 10:26:23 AM
// Design Name: 
// Module Name: testbench
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


module testbench(
    output [31:0]rg_tb[31:0],
    output [31:0]test
    );
    
    reg CLK100MHz;
    reg [8:0]key;
    reg [3:0]ina,inb;

   CPU_core CPU_core (
    .CLK(CLK100MHz),
    .key(key),
    .ina(ina),
    .inb(inb),
    .rg_tb(rg_tb),
    .test(test)
    );

    digitron_display digitron_display(
        .CLK(CLK100MHz),
        .switch(ina[0]),
        .data1(24'b000000000000000000000001),
        .data2(24'b110000000000000000000000),
        .digitronA_out(digitronA_out),
        .digitronB_out(digitronB_out),
        .digitron_out(digitron_out),
        .digitron_sel(digitron_sel)
    );

    initial
    begin
    CLK100MHz = 0;
    key = 9'b111111111;
    ina = 4'b0000;
    inb = 4'b0000;
    //#10 PROGRAM =1;
    end
    always
    begin
    #1 CLK100MHz = ~CLK100MHz;
    end
endmodule
