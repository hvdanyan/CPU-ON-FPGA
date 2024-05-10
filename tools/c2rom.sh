#!/bin/bash
for line in "$@"
do  
    # Compile the C file with the linker script
    riscv32-unknown-elf-gcc -T link.ld -o "${line%.*}.o" "$line"

    # Disassemble the object file
    riscv32-unknown-elf-objdump -d "${line%.*}.o" > "${line%.*}.d"

    # Convert the assembly to ROM format
    python3 asm2rom.py < "${line%.*}.d" > "ROM.v"
done

