`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Hu
// 
// Create Date: 03/26/2024 10:08:59 PM
// Design Name: 
// Module Name: digitron_display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Control the display of the digitrons.
// Here are 2 kinds of the distrons, totally 8 digitrons. 6 of them are together without decoding and the other 2 are separated with decoding. 
//
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module digitron_display(
    input CLK,
    input switch,
    input [23:0]data1,
    input [23:0]data2,

    output [3:0]digitronA_out,
    output [3:0]digitronB_out,
    output [7:0]digitron_out,
    output [3:0]digitron_sel
    );

    // Clock division
    wire clk_100MHz,clk_1KHz;
    assign clk_100MHz = CLK;

    clock_division #(.DIVCLK_CNTMAX(49999)) my_clock(
        .clk_in(CLK),
        .clk_div(clk_1KHz)
    );

    // digitron to be displayed
    reg [1:0] cnt = 0;

    always@(posedge clk_1KHz) begin
    if(cnt == 2'b11)
        cnt <= 2'b00;
    else
        cnt <= cnt + 1'b1;
    end

    wire [1:0]bit_disp;
    assign bit_disp = cnt;

    // decode the selection of the digitron
    digitron_sel_decoder digitron_sel_decoder(
        .bit_disp(bit_disp),
        .seg_sel(digitron_sel)
    );

    wire [15:0]data;
    reg [3:0]data_disp;
    
    assign data = switch ? data2[23:8] : data1[23:8];
    always@(*)
    case(bit_disp)
        2'b00 : data_disp = data[15:12];
        2'b01 : data_disp = data[11:8];
        2'b10 : data_disp = data[7:4];
        2'b11 : data_disp = data[3:0];
    endcase

    // decode the data to be displayed
    digitron_seg_decoder digitron_seg_decoder(
        .data_disp(data_disp),
        .seg_led(digitron_out)
    );

    assign {digitronB_out,digitronA_out} = switch ? data2[7:0] : data1[7:0];
endmodule
