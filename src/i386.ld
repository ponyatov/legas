/* https://www.cs.vu.nl/~herbertb/misc/writingkernels.txt */

_bss_size   = 8K;
_stack_size = 8K;

ENTRY(_stub)
OUTPUT(elf_i386)

/* phys = 0x00100000; */

. = 0x100000; /* Tells GRUB to load the kernel starting at the 1MB */

SECTIONS
{
    .text : /* phys : AT(phys) { */
    {
        . = ALIGN(4K);
        _boot = .;
            KEEP(*(.multiboot*))
        . = ALIGN(4K);
        _text = .;
            *(.text*)
            *(.eh_frame*)
        . = ALIGN(4K);
        _rodata = .;
            *(.rodata*)
    }

    .data : /* AT(phys + (data - code)) */
    {
        . = ALIGN(4K);
        _data = .;
            *(.data*)
    }

    .bss : /* AT(phys + (bss - code)) */
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
