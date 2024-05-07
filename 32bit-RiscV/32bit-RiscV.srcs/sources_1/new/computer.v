`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2024 09:24:43 PM
// Design Name: 
// Module Name: computer
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


module computer(
    input CLK100MHz,
    input [8:0]key,
    input [3:0]ina,inb,
    output [7:0]digitron_out,
    output [3:0]digitron_sel,
    output [3:0]digitronA_out,digitronB_out
    );

    wire CLK_FAST,CLK_SLOW;

    parameter DIVCLK_CNT_FAST = 49999;
    clock_division #(.DIVCLK_CNTMAX(DIVCLK_CNT_FAST)) clock_division_FAST_inst(// 100MHz/50000 = 2000Hz
      .clk_in(CLK100MHz),
      .clk_div(CLK_FAST)
      );

    parameter DIVCLK_CNT_SLOW = 19999999;
    clock_division #(.DIVCLK_CNTMAX(DIVCLK_CNT_SLOW)) clock_division_SLOW_inst(// 100MHz/20000000 = 5Hz
      .clk_in(CLK100MHz),
      .clk_div(CLK_SLOW)
      );

   CPU_core CPU_core (
    .CLK(CLK_SLOW),
    .key(key),
    .ina(ina),
    .inb(inb),
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

endmodule
