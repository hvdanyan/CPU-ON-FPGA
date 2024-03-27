`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/08 17:21:40
// Design Name: 
// Module Name: clock_division
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// Divide the clock frequency. Defaultly divide the clock frequency by 50000.
//
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clock_division #(
    parameter DIVCLK_CNTMAX = 49999)(
    input clk_in,
    output clk_div
    );

    reg [31:0] cnt = 0; 
    reg clk_div_reg = 0;

    always@(posedge clk_in) begin
        if(cnt == DIVCLK_CNTMAX) begin
            cnt <= 0;
            clk_div_reg <= ~clk_div_reg;
        end
        else begin
            cnt <= cnt + 1;
        end
    end 
    
    assign clk_div = clk_div_reg;
    endmodule
