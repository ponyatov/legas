/* https://www.cs.vu.nl/~herbertb/misc/writingkernels.txt */

_bss_size   = 8K;
_stack_size = 8K;

ENTRY(_stub)
OUTPUT(elf_i386)

. = 1M; /* load the kernel starting at the 1MB */

SECTIONS
{
    .boot : {
        _boot = .;
        KEEP(*(.multiboot*))
    }

    .text :
    {
        . = ALIGN(4K);
        _text = .;
            *(.text*)
            *(.eh_frame*)
        /* . = ALIGN(4K); */
        _rodata = .;
            *(.rodata*)
    }

    .data :
    {
        /* . = ALIGN(4K); */
        _data = .;
            *(.data*)
    }

   .bss :
    {
        . = ALIGN(4K);
        _bss = .;
            *(.bss*)
            . = . + _bss_size;
    }

    .stack : {
        . = ALIGN(4K);
            . = . + _stack_size;
        _stack = .;
    }

        _end = .;

    /DISCARD/ :
    {
        *(.debug*)
        *(.comment*)
    }
}
