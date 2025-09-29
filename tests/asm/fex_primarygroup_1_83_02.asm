; BITS: 64
; SOURCE: FEX PrimaryGroup/1_83_02.asm
; FEX_SHA256: 1a032f6bd750bba2b2368ef698e78345e72753a865a72672b03ac9706fb97a6d
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

clc
adc word [rdx + 8 * 0 + 2], -31
clc
adc dword [rdx + 8 * 1 + 0], -31
clc
adc qword [rdx + 8 * 2 + 0], -31

stc
adc word [rdx + 8 * 0 + 4], -31
stc
adc dword [rdx + 8 * 1 + 0], -31
stc
adc qword [rdx + 8 * 2 + 0], -31

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt