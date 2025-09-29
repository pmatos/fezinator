; BITS: 64
; SOURCE: FEX PrimaryGroup/1_83_03_2.asm
; FEX_SHA256: d0a1f2cf75e7e00da756f482d4f8046fa9a1559d5c6f1b8036063eb50ec8674a
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

clc
lock sbb word [rdx + 8 * 0 + 2], -31
clc
lock sbb dword [rdx + 8 * 1 + 0], -31
clc
lock sbb qword [rdx + 8 * 2 + 0], -31

stc
lock sbb word [rdx + 8 * 0 + 4], -31
stc
lock sbb dword [rdx + 8 * 1 + 0], -31
stc
lock sbb qword [rdx + 8 * 2 + 0], -31

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt