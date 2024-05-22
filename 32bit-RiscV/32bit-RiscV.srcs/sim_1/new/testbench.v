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
    
    reg CLK;
    reg [8:0]key;
    reg [3:0]ina,inb;
    parameter BIT_INDEX = 12 - 1;

    wire [31:0]rom_data, rom_addr;
    wire [31:0]ram_out_data, ram_in_data, ram_addr;
    wire ram_write_en;
    wire [23:0]data1, data2;

    cache_data #(.BIT_INDEX(BIT_INDEX)) RAM(
        .clock(CLK),
        .addr(ram_addr[BIT_INDEX:0]),
        .data_in(ram_in_data),
        .write_en(ram_write_en),
        .data_out(ram_out_data),
        .print_data1(data1),
        .print_data2(data2)
    );

    cache_instr #(.BIT_INDEX(BIT_INDEX)) ROM(
        .clock(CLK),
        .addr(rom_addr[BIT_INDEX:0]),
        .data(rom_data)
    );

    CPU_core #(.BIT_INDEX(BIT_INDEX)) CPU_core(
        .CLK(CLK),
        .key(key),
        .ina(ina),
        .inb(inb),
        .instr_data(rom_data),
        .instr_addr(rom_addr),
        .data_out_data(ram_out_data),
        .data_write_en(ram_write_en),
        .data_in_data(ram_in_data),
        .data_addr(ram_addr),
        .rg_tb(rg_tb),
        .test(test)
);

    digitron_display digitron_display(
        .CLK(CLK),
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
    CLK = 0;
    key = 9'b111111111;
    ina = 4'b0000;
    inb = 4'b0000;
    //#10 PROGRAM =1;
    end
    always
    begin
    #1 CLK = ~CLK;
    end
endmodule
