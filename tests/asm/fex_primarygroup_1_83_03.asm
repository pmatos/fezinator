; BITS: 64
; SOURCE: FEX PrimaryGroup/1_83_03.asm
; FEX_SHA256: 3fcb8684e721fd9317f6490f5737b9e7315b6825d6f896aeccc846a3e5f9a02c
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

clc
sbb word [rdx + 8 * 0 + 2], -31
clc
sbb dword [rdx + 8 * 1 + 0], -31
clc
sbb qword [rdx + 8 * 2 + 0], -31

stc
sbb word [rdx + 8 * 0 + 4], -31
stc
sbb dword [rdx + 8 * 1 + 0], -31
stc
sbb qword [rdx + 8 * 2 + 0], -31

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt