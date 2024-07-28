    .file "startup.s"
    .section .text.startup
    .global _start

_start:
    li	sp,-257
    jal ra,main
    lui	t0,0x1
    addi	t0,t0,-4
    sw   a0,0(t0) #将a0写入到0xffc的位置
    
loop:
    j loop
