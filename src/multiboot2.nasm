; https://os.phil-opp.com/multiboot-kernel/

section .multiboot2

MAGIC     equ 0xe85250d6
ARCHi386  equ 0
HDRLENGTH equ (header_end - header_start)
CHECKSUM  equ MAGIC + ARCHi386 + HDRLENGTH

header_start:
    dd MAGIC     ; magic number (multiboot 2)
    dd ARCHi386  ; architecture 0 (protected mode i386)
    dd HDRLENGTH ; header length
    ; checksum
    dd (0x100000000 - CHECKSUM)

    ; insert optional multiboot tags here

    ; required end tag
    dw 0    ; type
    dw 0    ; flags
    dd 8    ; size
header_end:
