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
    output [3:0]digitronA_out,digitronB_out,
    output [7:0]led
    );

    parameter BIT_INDEX = 12 - 1;

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

    wire CLK = CLK_SLOW;

    wire [31:0]rom_data, rom_addr;
    wire [31:0]ram_out_data, ram_in_data, ram_addr;
    wire ram_write_en;
    wire [23:0]data1, data2;

    RAM #(.BIT_INDEX(BIT_INDEX)) RAM(
        .clock(CLK),
        .addr(ram_addr[BIT_INDEX:0]),
        .data_in(ram_in_data),
        .write_en(ram_write_en),
        .data_out(ram_out_data),
        .print_data1(data1),
        .print_data2(data2)
    );

    ROM #(.BIT_INDEX(BIT_INDEX)) ROM(
        .clock(CLK),
        .addr(rom_addr[BIT_INDEX:0]),
        .data(rom_data)
    );


    wire [31:0]rg_tb[31:0];
    wire [31:0]test;
    CPU_core #(.BIT_INDEX(BIT_INDEX)) CPU_core(
        .CLK(CLK),
        .key(key),
        .ina(ina),
        .inb(inb),
        .rom_data(rom_data),
        .rom_addr(rom_addr),
        .ram_out_data(ram_out_data),
        .ram_write_en(ram_write_en),
        .ram_in_data(ram_in_data),
        .ram_addr(ram_addr),
        .rg_tb(rg_tb),
        .test(test)
);

    digitron_display digitron_display(
        .CLK(CLK100MHz),
        .switch(ina[0]),
        .data1(data1),
        .data2(data2),
        .digitronA_out(digitronA_out),
        .digitronB_out(digitronB_out),
        .digitron_out(digitron_out),
        .digitron_sel(digitron_sel)
    );

    wire led = {rom_data[13:12],rom_data[5:0]};

endmodule
