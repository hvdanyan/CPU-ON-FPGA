#!/bin/bash
for line in "$@"
do  
    # Compile the C file
    riscv32-unknown-elf-gcc -c "$line"

    # Disassemble the object file
    riscv32-unknown-elf-objdump -d "${line%.*}.o" > "${line%.*}.asm"

    # Convert the assembly to ROM format
    python3 asm2rom.py < "${line%.*}.asm" > "program.v"
done

