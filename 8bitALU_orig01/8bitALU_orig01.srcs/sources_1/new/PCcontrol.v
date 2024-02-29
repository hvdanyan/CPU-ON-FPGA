`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/16 10:30:55
// Design Name: 
// Module Name: PCcontrol
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: PCcontrol 是一个在时序上与流水线的"执行"同步的控制器，它的工作是1、批准R1赋值到PC寄存器；
//2、拦截下一周期的"取指""解码""执行"操作
// 3、注意：写回操作不需要拦截。
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
//0.02 - bug fixed: PCwrite register will be flushed too.
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PCcontrol(
    input CLK,
    input activate,
    input [1:0]CS,
    input [1:0]jumpcode,
    input [7:0]ALUout,
    output reg [2:0] BHTdata,
    output reg PCwrite,PCtraceback
    ); 
   
    
    wire jump;//whether jump or not
    //assign jump=(jumpcode[1]&~ALUout[7]&~ALUout[6]&~ALUout[5]&~ALUout[4]&~ALUout[3]&~ALUout[2]&~ALUout[1]&~ALUout[0])|(jumpcode[0]&~ALUout[7]&(ALUout[6]|ALUout[5]|ALUout[4]|ALUout[3]|ALUout[2]|ALUout[1]|ALUout[0]))|(jumpcode[1]&jumpcode[0]);
    assign jump=~PCwrite&((jumpcode[1]&~ALUout[7]&~ALUout[6]&~ALUout[5]&~ALUout[4]&~ALUout[3]&~ALUout[2]&~ALUout[1]&~ALUout[0])|(jumpcode[0]&~ALUout[7]&(ALUout[6]|ALUout[5]|ALUout[4]|ALUout[3]|ALUout[2]|ALUout[1]|ALUout[0]))|(jumpcode[1]&jumpcode[0]));
    reg [1:0]activate_delay;
    reg [1:0][1:0]CS_delay;
    always @(posedge CLK)
    begin
        activate_delay[0] <= activate;
        activate_delay[1] <= activate_delay[0];//做两步延迟
        CS_delay[0]<=CS;
        CS_delay[1]<=CS_delay[0];
        PCwrite <= (~activate_delay[1]&jump)|(activate_delay[1]&CS_delay[1][1]&~jump)|(activate_delay[1]&~CS_delay[1][1]&jump)?1:0;//when it's different,meaning predicting wrong.
        PCtraceback <= activate_delay[1]&CS_delay[1][1]&~jump;//动态预测已激活，且发生了跳转，但是实际上不需要跳转时为1
        //四种情形，①预测器预测跳转，实际确实跳转。
        //②预测器预测不跳转，实际确实不跳转。
        //③预测器预测不跳转，实际跳转。
        //④预测器预测跳转，实际不跳转。
        //一二两种情况只需要PCwrite为0即可。三四情况PCwrite需要介入，并且四情况比较复杂，需要将PC寄存器回溯到跳转前。
        //when ~activate_delay[1]&jump, just make PC=regB.
        //But when activate_delay[1]&~jump, return traceback.
        
        BHTdata[2]<= jumpcode[1]|jumpcode[0];
    end
    CS_FSM CS_FSM_inst(CLK,activate_delay[1],jump,CS_delay[1],BHTdata[1:0]);
endmodule
