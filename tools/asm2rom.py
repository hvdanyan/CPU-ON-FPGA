"""
Designed by Hu Yan @ 2024/5/10, in Nanjing University.

This script is used to convert the output of riscv32-unknown-elf-objdump to a ROM module in Verilog.
"""

import sys

OFFSET = 9 #The offset of the first instruction in the ROM

header = """`timescale 1ns / 1ps

module program #(
    parameter BIT_INDEX = 11
    )(
    input clock,
    input [BIT_INDEX:0]addr,
    output [31:0]data
    );

    wire [31:0]Memory[0:1023];
    
    assign Memory[0] = 32'h0;
    assign Memory[1] = 32'h0;
    assign Memory[2] = 32'h0;
    assign Memory[3] = 32'hFFF00113; //li	sp,-1
    assign Memory[4] = 32'h14000ef;//jal ra,0x14
    assign Memory[5] = 32'h000012b7; //lui	t0,0x1
    assign Memory[6] = 32'hffc28293; //addi	t0,t0,-4
    assign Memory[7] = 32'h00a2a023; //sw   a0,0(t0) 将a0写入到0xffc的位置
    assign Memory[8] = 32'h6f; //halt
"""

footer = """
    assign data = Memory[addr[BIT_INDEX:2]];

endmodule"""

def process_line(line):
    parts = line.split()
    if len(parts) < 3 or not parts[0].endswith(':'):
        return None
    #print(line)
    Num = int(parts[0][:-1],16)//4
    instruction = parts[1]

    if len(parts) == 3:
        annotation = parts[2]
    elif len(parts) == 4:
        annotation = f"{parts[2]} {parts[3]}"
    else:
        annotation = f"{parts[2]} {parts[3]} {parts[4]}"
        

    return Num,instruction,annotation

if __name__ == '__main__':
    print(header)
    drop_lines = 3 #Due to the first 3 lines are not instructions
    for line in sys.stdin:
        if drop_lines > 0:
            drop_lines -= 1
            continue
        processed = process_line(line)
        if processed is not None:
            Num,instruction,annotation = processed
            print(f"    assign Memory[{Num+OFFSET}] = 32'h{instruction}; // {annotation}")
    print(footer)
