`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/01/07 19:51:42
// Design Name: 
// Module Name: computer
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


  module computer(
    input CLK100MHz,CLK3Hz,MANCLK,
    input [3:0]ina,
    input [3:0]inb,
    input PROGRAM1,PROGRAM2,
    output [7:0]seg,
    output [7:0]MRegout,
    output [7:0]Regout,
    output [3:0]Regsel
    
    //BELOW FOR SIMULATION USE
    //,output [7:0]instraddr,Reg_b,Reg_a,Reg_output,RamM,ALUout,
    //output  Awrite_delay,Bwrite_delay,Mwrite_delay,PCwrite,
    //output [0:2][7:0]ramdisplay,
    //output activate
    
);
     //CLK switch
     wire stable_MANCLK;
     Button_stabilization Button_stabilization_inst(CLK100MHz,MANCLK,stable_MANCLK);

     wire CLK_FAST,CLK_SLOW;

     parameter DIVCLK_CNT_FAST = 49999;
     clock_division #(.DIVCLK_CNTMAX(DIVCLK_CNT_FAST)) clock_division_FAST_inst(// 100MHz/50000 = 2000Hz
      .clk_in(CLK100MHz),
      .divclk(CLK_FAST)
      );

     parameter DIVCLK_CNT_SLOW = 19999999;
     clock_division #(.DIVCLK_CNTMAX(DIVCLK_CNT_SLOW)) clock_division_SLOW_inst(// 100MHz/20000000 = 5Hz
      .clk_in(CLK100MHz),
      .divclk(CLK_SLOW)
      );

      assign CLK = (ina[0]) ? CLK_FAST : CLK_SLOW ;//choose the clock source

     wire [7:0]Reg_a;
     wire [7:0]Reg_b;
     wire [7:0]RamM;
     wire Awrite,Bwrite,Mwrite,PCwrite;
     wire Awrite_delay,Bwrite_delay,Mwrite_delay;
     wire [7:0]ALUout;//the output of ALU
     wire [7:0]instraddr;
     wire [7:0]instr,regBtransmit;
     wire [2:0]opcode;
     wire [1:0]jumpcode;
     wire [0:2][7:0]ramdisplay;
     wire [7:0] Reg_output;
     //confirm the instruction
     wire activate,PCtraceback;
     wire [2:0]BHTdata;
     wire [2:0][7:0]PC_delay;
     wire [7:0]BTA;
     wire [1:0]CS;
     PCregister PCregister_inst(CLK,PCwrite,activate,CS[1],PCtraceback,~PROGRAM1,~PROGRAM2,Reg_b,BTA,instraddr,PC_delay);

     dynamic_predictor dynamic_predictor_inst(CLK,instraddr,PC_delay[2],BHTdata,Reg_b,BTA,CS,activate);
     
    instruction_fetch instruction_fetch_inst(
      .CLK(CLK),
      .instraddr(instraddr),
      .PCwrite(PCwrite),
      .instr(instr)
    ); // Here complete INSTRUCTION_FETCH

    instruction_decode instruction_decode_inst(
      .CLK(CLK),
      .instr(instr),
      .PCwrite(PCwrite),
      .Awrite(Awrite),
      .Bwrite(Bwrite),
      .Mwrite(Mwrite),
      .opcode(opcode),
      .jumpcode(jumpcode),
      .regBtransmit(regBtransmit)
    ); // control whether change RegB or execute ALU

    instruction_execute instruction_execute_inst(
      .CLK(CLK),
      .opcode(opcode),
      .Reg_a(Reg_a),
      .Reg_b(Reg_b),
      .RamM(RamM),
      .regBtransmit(regBtransmit),
      .PCwrite(PCwrite),
      .Awrite(Awrite),
      .Bwrite(Bwrite),
      .Mwrite(Mwrite),
      .Awrite_delay(Awrite_delay),
      .Bwrite_delay(Bwrite_delay),
      .Mwrite_delay(Mwrite_delay),
      .Reg_output(Reg_output),
      .ALUout(ALUout)
    ); // refresh the registers and output the seg.

    instruction_writeback instruction_writeback_inst(
      .CLK(CLK),
      .Awrite(Awrite_delay),
      .Bwrite(Bwrite_delay),
      .Mwrite(Mwrite_delay),
      .PCwrite(PCwrite),
      .Reg_output(Reg_output),
      .Reg_a(Reg_a),
      .Reg_b(Reg_b),
      .RamM(RamM),
      .ramdisplay(ramdisplay)
    ); // transmit the value from output register to A register, B register, or RAM

    // confirm PC counter's next step
    PCcontrol PCcontrol_inst(
      .CLK(CLK),
      .activate(activate),
      .CS(CS),
      .jumpcode(jumpcode),
      .ALUout(ALUout),
      .BHTdata(BHTdata),
      .PCwrite(PCwrite),
      .PCtraceback(PCtraceback)
    );
    
    assign seg = ALUout;//LEDs

    display display_inst(CLK100MHz,ina,instraddr,Reg_a,Reg_b,RamM,ramdisplay,MRegout,Regout,Regsel);
    //display display_inst(CLK100MHz,ina,instraddr,Reg_b,Bwrite_delay,Reg_output,ramdisplay,MRegout,Regout,Regsel);
    //In order to figuret out why PCreg doesn't work, I make a delay register.

endmodule