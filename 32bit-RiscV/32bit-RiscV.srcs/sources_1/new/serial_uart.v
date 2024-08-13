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
    input cpu_clk,seri_clk,
    input rst,

    //输入输出数据
    input rx,
    output [7:0] stdin_data,
    output stdin_rd_available,
    input stdin_rd_request,

    input [7:0]stdout_data,
    output tx,
    //缓冲区清空
    input stdout_wr_en,
    output stdout_wr_ack//表示已经写入。
    );

    wire [7:0] po_data;
    wire po_flag;
    wire fifo_stdin_empty;

    fifo_stdin fifo_stdin_inst (
        .wr_clk(seri_clk),  // input wire wr_clk
        .rd_clk(cpu_clk),  // input wire rd_clk
        .rst(~rst),        // input wire rst
        .din(po_data),        // input wire [7 : 0] din
        .wr_en(po_flag),    // input wire wr_en
        .rd_en(stdin_rd_request & ~fifo_stdin_empty),    // input wire rd_en
        .dout(stdin_data),      // output wire [7 : 0] dout
        .full(),      // output wire full
        .empty(fifo_stdin_empty),   // output wire empty
        .valid(stdin_rd_available)    // output wire valid
    );

    uart_rx uart_rx_inst(
        .sys_clk (seri_clk)    ,   //系统时钟50MHz
        .sys_rst_n (rst)  ,   //全局复位
        .rx (rx)  ,   //串口接收数据
        .po_data (po_data)    ,   //串转并后的8bit数据
        .po_flag  (po_flag)       //串转并后的数据有效标志信号
    );

    //我们在内存中的某一块区域分配固定的区域用来接收输入的数据。并约定内存的另一块区域表示stdout的写使能。
    //利用empty信号决定是否需要输出。
    wire [7:0] dout;
    wire fifo_stdout_empty,trans_finish;
    reg rd_en_reg,pi_flag_reg;

    fifo_stdout fifo_stdout_inst (
        .wr_clk(cpu_clk),  // input wire wr_clk
        .rd_clk(seri_clk),  // input wire rd_clk
        .rst(~rst),        // input wire rst
        .din(stdout_data),        // input wire [7 : 0] din
        .wr_en(stdout_wr_en),    // input wire wr_en
        .rd_en(rd_en_reg),    // input wire rd_en
        .dout(dout),      // output wire [7 : 0] dout
        .full(),      // output wire full
        .wr_ack(stdout_wr_ack),  // output wire wr_ack
        .empty(fifo_stdout_empty)    // output wire empty
    );

    uart_tx uart_tx_inst(
        .sys_clk(seri_clk),
        .sys_rst_n(rst),
        .pi_data(dout),
        .pi_flag(pi_flag_reg),
        .tx(tx),
        .trans_finish(trans_finish)
    );


    //用于控制串口发送模块的状态
    reg trans_finish_reg_lag;
    always @(posedge seri_clk or negedge rst)begin
        if (!rst) begin
            // 同步复位
            pi_flag_reg <= 1'b0;
            trans_finish_reg_lag <= 1'b0;
            rd_en_reg <= 1'b0;
        end else begin
            trans_finish_reg_lag <= trans_finish;
            
            if (!trans_finish_reg_lag && trans_finish) begin
                pi_flag_reg <= 1'b0;
            end else if (fifo_stdout_empty == 1'b0 && pi_flag_reg == 1'b0) begin
                rd_en_reg <= 1'b1;
                pi_flag_reg <= 1'b1;
            end else if (pi_flag_reg == 1'b1) begin
                rd_en_reg <= 1'b0;
            end
        end
    end 

endmodule
