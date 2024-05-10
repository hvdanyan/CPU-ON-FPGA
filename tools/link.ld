SECTIONS
{
    . = 0x1c;
    .text : { *(.text) }
    . = ALIGN(4);
    __global_pointer$ = . + 0x800;
    . = ALIGN(4);
    .data : { *(.data) }
    . = ALIGN(4);
    .bss : 
    { 
        __bss_start = .;
        *(.bss) 
        *(COMMON)
        . = ALIGN(4);
        _end = .;
    }
}

