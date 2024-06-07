; https://os.phil-opp.com/multiboot-kernel/

bits 32

section .multiboot1

PAGE_ALIGN	equ 1<<0
MEMORY_INFO	equ 1<<1                                         

MAGIC1    equ 0x1BADB002
MB1FLAGS  equ (PAGE_ALIGN|MEMORY_INFO)
HDRLENGTH equ (header_end - header_start)
CHECKSUM  equ (MAGIC1 + MB1FLAGS)

header_start:
    dd MAGIC1
    dd MB1FLAGS
    dd -CHECKSUM
header_end:
    extern _stub
    jmp _stub
