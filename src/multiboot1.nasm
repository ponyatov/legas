; https://os.phil-opp.com/multiboot-kernel/

bits 32

section .multiboot2

PAGE_ALIGN	equ 1<<0
MEMORY_INFO	equ 1<<1                                         

MAGIC     equ 0x1BADB002
MBFLAGS   equ (PAGE_ALIGN|MEMORY_INFO)
HDRLENGTH equ (header_end - header_start)
CHECKSUM  equ MAGIC + MBFLAGS

header_start:
    dd MAGIC     ; magic number (multiboot 2)
    dd MBFLAGS   ; architecture 0 (protected mode i386)
    ; dd HDRLENGTH ; header length
    ; checksum
    dd (0x100000000 - CHECKSUM)

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
