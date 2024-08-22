`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 10:47:36 AM
// Design Name: 
// Module Name: PC_register
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


module PC_register(
    input clock,
    input _reset,
    input [31:0]predict_PC,
    input [31:0]new_real_PC,//差2个时钟周期
    input predict_right,
    input _risk_data_hazard,
    output [31:0]PC
    );

    reg [31:0]PC_reg;

    always @(posedge clock or negedge _reset) begin
        if (_reset == 0) begin
            PC_reg <= 32'b0;
        end
        else begin
            if(predict_right && _risk_data_hazard)begin
                PC_reg <= predict_PC;
            end
            else if(!_risk_data_hazard)begin
                //PC保持原样
            end
            else begin
            PC_reg <= new_real_PC;
            end
        end
    end

    assign PC = PC_reg;

    initial
    begin
        PC_reg = 0;
    end
endmodule
