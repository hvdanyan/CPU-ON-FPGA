`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2024 12:06:44 AM
// Design Name: 
// Module Name: cache_data
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
//待办：脏位清零。

module cache_data #(
    parameter BIT_INDEX = 12 - 1
    )(
    input clock,
    input _reset,
    input [BIT_INDEX:0]addr,
    input [31:0]data_in,
    input write_en,
    output reg data_hit,
    output [31:0]data_out,
    output [23:0]print_data1,
    output [23:0]print_data2,

    //为了串口开发的新端口：
    input stdin_wr_ack,
    output stdin_wr_en,

    output [7:0]stdin_data
    );

    //reg [7:0]Memory[0:4095];// Another syntax is [0:4095][7:0]Memory

    /*always @(posedge clock) begin
        if(write_en) begin
            {Memory[{addr[BIT_INDEX:2],2'b11}],Memory[{addr[BIT_INDEX:2],2'b10}],Memory[{addr[BIT_INDEX:2],2'b01}],Memory[{addr[BIT_INDEX:2],2'b00}]} <= data_in;
        end
    end

    assign data_out = {Memory[{addr[BIT_INDEX:2],2'b11}],Memory[{addr[BIT_INDEX:2],2'b10}],Memory[{addr[BIT_INDEX:2],2'b01}],Memory[{addr[BIT_INDEX:2],2'b00}]};
    */

    /*//非对齐版本代码
    always @(posedge clock) begin
        if(write_en) begin
            {Memory[addr[BIT_INDEX:0] + 3],Memory[addr[BIT_INDEX:0] + 2],Memory[addr[BIT_INDEX:0] + 1],Memory[addr[BIT_INDEX:0] + 0]} <= data_in;
        end
    end

    //assign data_out = {Memory[addr[BIT_INDEX:0] + 3],Memory[addr[BIT_INDEX:0] + 2],Memory[addr[BIT_INDEX:0] + 1],Memory[addr[BIT_INDEX:0] + 0]};
    reg [31:0]data_out_reg;
    always @(posedge ~clock)begin
        data_out_reg <= {Memory[addr[BIT_INDEX:0] + 3],Memory[addr[BIT_INDEX:0] + 2],Memory[addr[BIT_INDEX:0] + 1],Memory[addr[BIT_INDEX:0] + 0]};
    end
    assign data_out = data_out_reg;
    */

    //我们对于未对齐的数据，高位补0。
    wire [31:0]blk_mem_douta;
    blk_mem_32_4096 blk_mem_32_4096_inst00 (
        .clka(~clock),    // input wire clka
        .wea(write_en),      // input wire [0 : 0] wea
        .addra(addr[BIT_INDEX:2]),  // input wire [9 : 0] addra
        .dina(data_in),    // input wire [31 : 0] dina
        .douta(blk_mem_douta)  // output wire [31 : 0] douta
    );


    //自定义内存空间：
    reg [7:0]Memory_addon[0:255];

    reg [31:0]lut_douta;
    always @(posedge ~clock)begin//自定义内存空间读出
        lut_douta <= {Memory_addon[{addr[7:2],2'b11}],Memory_addon[{addr[7:2],2'b10}],Memory_addon[{addr[7:2],2'b01}],Memory_addon[{addr[7:2],2'b00}]};
    end

    //根据地址决定从自定义内存读出或者从bram读出,对于没有对齐的数据，采取高位补零的方式
    assign data_out = ((addr[BIT_INDEX:8] == 4'hf)?lut_douta:blk_mem_douta)>>>(addr[1:0]*8);

    //数码管显示
    assign print_data1 = {Memory_addon[8'hfe],Memory_addon[8'hfd],Memory_addon[8'hfc]};
    assign print_data2 = {16'b0,Memory_addon[8'hff]};



    //串口模块的代码/自定义内存空间的写入：

    always @(negedge clock or posedge stdin_wr_ack)begin //当接收到fifo发回来的写入成功的信号时，清零标记位
        if(stdin_wr_ack)begin
                Memory_addon[8'hfb][7] <= 0;
            end
        else if(addr[BIT_INDEX:8] == 4'hf)begin
            if(write_en)begin
                {Memory_addon[{addr[7:2],2'b11}],Memory_addon[{addr[7:2],2'b10}],Memory_addon[{addr[7:2],2'b01}],Memory_addon[{addr[7:2],2'b00}]} <= data_in;
            end
        end
    end

    //串口交互
    assign stdin_data = Memory_addon[8'hf8];
    assign stdin_wr_en = Memory_addon[8'hfb][7];
    
    initial
    begin
        for(int i=0;i<256;i=i+1)
        begin
            Memory_addon[i] = 32'b0;
        end
    end

endmodule
