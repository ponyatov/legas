; https://os.phil-opp.com/multiboot-kernel/

bits 32

section .multiboot2

MAGIC2    equ 0xE85250D6
ARCHi386  equ 0
HDRLENGTH equ (header_end - header_start)
CHECKSUM  equ (MAGIC2 + ARCHi386 + HDRLENGTH)

header_start:
    dd MAGIC2    ; magic number (multiboot 2)
    dd ARCHi386  ; architecture 0 (protected mode i386)
    dd HDRLENGTH ; header length
    dd -CHECKSUM

    ; insert optional multiboot tags here

    ; required end tag
    dw 0    ; type
    dw 0    ; flags
    dd 8    ; size
header_end:

section .text
global _stub
extern _stack
_stub:
    mov esp, _stack
    jmp $+2
    mov dword [0xb8000], 0x2f4b2f4f
    hlt
