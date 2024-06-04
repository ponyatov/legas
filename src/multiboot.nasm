; https://mars-research.github.io/posts/2020/10/hello-world-on-bare-metal/
; https://www.cs.vu.nl/~herbertb/misc/writingkernels.txt

; Multiboot v1 - Compliant Header for QEMU 
; We use multiboot v1 since Qemu "-kernel" doesn't support 
; multiboot v2

[BITS 32]
global _start

; This part MUST be 4-byte aligned, so we solve that issue using 'ALIGN 4'
ALIGN 4
section .multiboot
    ; Multiboot macros to make a few lines later more readable
    MULTIBOOT_PAGE_ALIGN	equ 1<<0
    MULTIBOOT_MEMORY_INFO	equ 1<<1                                         
    MULTIBOOT_HEADER_MAGIC	equ 0x1BADB002 ; magic number
    MULTIBOOT_HEADER_FLAGS	equ MULTIBOOT_PAGE_ALIGN | MULTIBOOT_MEMORY_INFO
    ; (magic number + checksum + flags should be equal 0)
    MULTIBOOT_CHECKSUM	equ - (MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)

    ; This is the GRUB Multiboot header. A boot signature
    dd MULTIBOOT_HEADER_MAGIC
    dd MULTIBOOT_HEADER_FLAGS
    dd MULTIBOOT_CHECKSUM

_stub:
    mov esp, _stack
    extern _start
    call _start
    jmp $
