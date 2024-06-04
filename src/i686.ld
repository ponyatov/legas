/* https://www.cs.vu.nl/~herbertb/misc/writingkernels.txt */

ENTRY(_stub)
phys = 0x00100000;
SECTIONS
{
  .text /* phys : AT(phys) { */
  {
    _text = .;
    *(.multiboot*)
    *(.text*)
    . = ALIGN(4096);
    _rodata = .;
    *(.rodata*)
    . = ALIGN(4096);
  }

  /* .data : AT(phys + (data - code)) */
  .data {
  {
    _data = .;
    *(.data*)
    . = ALIGN(4096);
  }
  .bss : AT(phys + (bss - code))
  {
    _bss = .;
    *(.bss*)
    . = ALIGN(4096);
  }
  end = .;
  _stack = .;
}
