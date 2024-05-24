OUTPUT_FORMAT("elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(kernel)

SECTIONS
{
    . = 0xB8000;
    .vga : { *(.vga) }
    /* KEEP(*(.vga)) */
    . = 1M;
    .multiboot BLOCK(4K) : ALIGN(4K) { *(.multiboot) }
    .text BLOCK(4K) : ALIGN(4K) { *(.text) }
    .rodata BLOCK(4K) : ALIGN(4K) { *(.rodata) }
    .data BLOCK(4K) : ALIGN(4K) { *(.data) }
    .bss  BLOCK(4K) : ALIGN(4K) { *(COMMON) *(.bss) }
    /* /DISCARD/ BLOCK(4K) : ALIGN(4K) { *(.comment) } */
}
