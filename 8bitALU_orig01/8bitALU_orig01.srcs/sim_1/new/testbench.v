`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/10 10:57:42
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
    );
    reg CLK100MHz,PROGRAM;
    reg [3:0]ina;
    wire[7:0]instraddr,ARegout,BRegout,MRegout,Reg_output;
    //wire [2:0]opcode;
    wire  Awrite,Bwrite,Mwrite,PCwrite;
    wire [0:2][7:0]ramdisplay;
    wire activate;
    
    computer computer_inst(
    .CLK100MHz(CLK100MHz),
    .ina(ina),
    .PROGRAM1(PROGRAM),
    //.instr(instr),
    .RamM(MRegout),
    .instraddr(instraddr),
    .Reg_b(BRegout),
    .Reg_a(ARegout),
    //.opcode(opcode),
    .Awrite_delay(Awrite),
    .Bwrite_delay(Bwrite),
    .Mwrite_delay(Mwrite),
    .PCwrite(PCwrite),
    .Reg_output(Reg_output),
    .ramdisplay(ramdisplay),
    .activate(activate)
    );
    
    initial
    begin
    CLK100MHz = 0;
    PROGRAM = 0;
    ina = 4'b0001;
    #10 PROGRAM =1;
    end
    always
    begin
    #1 CLK100MHz = ~CLK100MHz;
    end
endmodule
