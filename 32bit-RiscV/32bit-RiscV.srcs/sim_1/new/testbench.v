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
    
    reg CLK,CLK_SLOW;
    reg [8:0]key;
    reg [3:0]ina,inb;
    reg _reset;
    reg rx;
    reg instr_hit;
    parameter BIT_INDEX = 12 - 1;

    wire [31:0]rom_data, rom_addr;
    wire [31:0]ram_out_data, ram_in_data, ram_addr;
    wire data_hit,ram_write_en;
    wire [23:0]data1, data2;
    wire tx;

    wire [7:0]stdin_data;
    wire stdout_wr_en,stdout_wr_ack;
    wire [7:0]stdout_data;

    cache_data #(.BIT_INDEX(BIT_INDEX)) RAM(
        .clock(CLK_SLOW),
        ._reset(_reset),
        .addr(ram_addr[BIT_INDEX:0]),
        .data_in(ram_in_data),
        .write_en(ram_write_en),
        .data_hit(data_hit),
        .data_out(ram_out_data),
        .print_data1(data1),
        .print_data2(data2),

        .stdin_rd_available(stdin_rd_available),
        .stdin_rd_request(stdin_rd_request),
        .stdin_data(stdin_data),
        
        .stdout_wr_ack(stdout_wr_ack),
        .stdout_wr_en(stdout_wr_en),
        .stdout_data(stdout_data)
    );

    cache_instr #(.BIT_INDEX(BIT_INDEX)) ROM(
        .clock(CLK_SLOW),
        .addr(rom_addr[BIT_INDEX:0]),
        .data(rom_data)
    );

    CPU_core #(.BIT_INDEX(BIT_INDEX)) CPU_core(
        .CLK(CLK_SLOW),
        ._reset(_reset),
        .ina(ina),
        .inb(inb),
        .instr_data(rom_data),
        .instr_addr(rom_addr),
        .instr_hit(instr_hit),
        .data_out_data(ram_out_data),
        .data_write_en(ram_write_en),
        .data_in_data(ram_in_data),
        .data_addr(ram_addr),
        .rg_tb(rg_tb),
        .test(test)
);

    digitron_display digitron_display(
        .CLK(CLK),
        .switch(_reset),
        .data1(24'b000000000000000000000001),
        .data2(24'b110000000000000000000000),
        .digitronA_out(digitronA_out),
        .digitronB_out(digitronB_out),
        .digitron_out(digitron_out),
        .digitron_sel(digitron_sel)
    );

    serial_uart serial_uart_inst(
        .cpu_clk(CLK_SLOW),
        .seri_clk(CLK),
        .rst(_reset),//随便取的复位键，低电平有效

        .rx(rx),
        .stdin_data(stdin_data),
        .stdin_rd_available(stdin_rd_available),
        .stdin_rd_request(stdin_rd_request),

        .stdout_data(stdout_data),
        .tx(tx),
        .stdout_wr_en(stdout_wr_en),
        .stdout_wr_ack(stdout_wr_ack)
    );

    initial
    begin
    CLK = 0;
    CLK_SLOW = 0;
    key = 9'b111111111;
    ina = 4'b0000;
    inb = 4'b0000;
    instr_hit = 1'b1;
    _reset = 1;
    rx = 1;
    #3 _reset = 0;
    #10 _reset =1;
    #20416 rx=0;
    #25624 rx=1;
    end
    always
    begin
        #1 CLK = ~CLK;
    end
    always
    begin
        #2 CLK_SLOW = ~CLK_SLOW;
    end
endmodule
