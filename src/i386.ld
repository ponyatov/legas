/* https://www.cs.vu.nl/~herbertb/misc/writingkernels.txt */

ENTRY(_stub)
OUTPUT(elf_i386)

phys = 0x00100000;
SECTIONS
{
  .text : /* phys : AT(phys) { */
  {
    _text = .;
    *(.multiboot*)
    *(.text*)
    . = ALIGN(4K);
    _rodata = .;
    *(.rodata*)
    . = ALIGN(4K);
  }

  .data : /* AT(phys + (data - code)) */
  {
    _data = .;
    *(.data*)
    . = ALIGN(4K);
  }
  .bss : /* AT(phys + (bss - code)) */
  {
    _bss = .;
    *(.bss*)
    . = ALIGN(4K);
  }
  .stack : {
  _stack = .;
    . = ALIGN(4K);
  }
  _end = .;
}
