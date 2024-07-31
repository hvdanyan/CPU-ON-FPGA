`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2024 05:20:11 PM
// Design Name: 
// Module Name: serial_uart
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


module serial_uart(
    input wr_clk,rd_clk,
    input rst,

    //输入输出数据
    input [7:0]din,
    output tx,

    //缓冲区清空
    input stdin_wr_en,
    output stdin_wr_ack//表示已经写入。
    );

    //我们在内存中的某一块区域分配固定的区域用来接收输入的数据。并约定内存的另一块区域表示stdin的写使能。
    //利用empty信号决定是否需要输出。
    wire [7:0] dout;
    reg rd_en_reg,pi_flag_reg;

    fifo_stdin fifo_stdin_inst (
        .wr_clk(wr_clk),  // input wire wr_clk
        .rd_clk(rd_clk),  // input wire rd_clk
        .rst(~rst),        // input wire rst
        .din(din),        // input wire [7 : 0] din
        .wr_en(stdin_wr_en),    // input wire wr_en
        .rd_en(rd_en_reg),    // input wire rd_en
        .dout(dout),      // output wire [7 : 0] dout
        .full(full),      // output wire full
        .wr_ack(stdin_wr_ack),  // output wire wr_ack
        .empty(empty)    // output wire empty
    );

    uart_tx uart_tx_inst(
        .sys_clk(rd_clk),
        .sys_rst_n(rst),
        .pi_data(dout),
        .pi_flag(pi_flag_reg),
        .tx(tx),
        .trans_finish(trans_finish)
    );

    reg trans_finish_reg_lag;
    always @(posedge rd_clk or negedge rst)begin
        if (!rst) begin
            // 同步复位
            pi_flag_reg <= 1'b0;
            trans_finish_reg_lag <= 1'b0;
            rd_en_reg <= 1'b0;
        end else begin
            trans_finish_reg_lag <= trans_finish;
            
            if (!trans_finish_reg_lag && trans_finish) begin
                pi_flag_reg <= 1'b0;
            end else if (empty == 1'b0 && pi_flag_reg == 1'b0) begin
                rd_en_reg <= 1'b1;
                pi_flag_reg <= 1'b1;
            end else if (pi_flag_reg == 1'b1) begin
                rd_en_reg <= 1'b0;
            end
        end
    end 

endmodule
