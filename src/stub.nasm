bits 32

section .text

global _stub
extern _stack

_stub:
    mov esp, _stack
    jmp $+2
    mov dword [0xb8000], 0x2f4b2f4f
    hlt
