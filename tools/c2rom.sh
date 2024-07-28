#!/bin/bash
for line in "$@"
do  
    # Compile the C file
    riscv32-unknown-elf-gcc -T link.ld -o "${line%.*}" "$line"  startup.S -nostdlib -march=rv32i

    # Disassemble the object file
    riscv32-unknown-elf-objdump -d "${line%.*}" > "${line%.*}.asm"

    # Convert the assembly to ROM format
    python3 asm2rom.py < "${line%.*}.asm" > "program.v"
done

