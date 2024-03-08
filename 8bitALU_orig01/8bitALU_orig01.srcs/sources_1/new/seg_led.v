`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/08 17:28:30
// Design Name: 
// Module Name: seg_led
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// It's shows the value on the led on the FPGA board to make the instructions visible.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module seg_led(CLK,regA,regB,seg_sel,seg_led);
input CLK;
input [7:0]regA;
input [7:0]regB;
output [3:0] seg_sel;
output [7:0] seg_led;
parameter DIVCLK_CNTMAX = 49999; //100M/50000 = 2khz
wire clk_1K;
//����ʱ�ӷ�Ƶģ��
clock_division #(.DIVCLK_CNTMAX(DIVCLK_CNTMAX)) my_clock(
.clk_in(CLK),
.divclk(clk_1K)
);
//����������ģ��
wire [1:0] bit_disp;
counter counter(
.clk(clk_1K),
.cnt(bit_disp)
);
//������·������ģ��
reg [3:0] data_disp;
always@(*)
case(bit_disp)
2'b00 : data_disp = regA[7:4];
2'b01 : data_disp = regA[3:0];
2'b10 : data_disp = regB[7:4] ;
2'b11 : data_disp = regB[3:0];
endcase
//���������λѡ����ģ��
seg_sel_decoder seg_sel_decoder(
.bit_disp(bit_disp),
.seg_sel(seg_sel)
);
//��������ܶ�������ģ��
seg_led_decoder seg_led_decoder(
.data_disp(data_disp),
.seg_led(seg_led)
);
endmodule

