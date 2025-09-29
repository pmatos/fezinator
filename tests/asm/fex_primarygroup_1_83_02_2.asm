; BITS: 64
; SOURCE: FEX PrimaryGroup/1_83_02_2.asm
; FEX_SHA256: 64fd52ad15d9599c2b7f645d10c6caf49f04cea0dc891e3cc834cc751f7d4964
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

clc
lock adc word [rdx + 8 * 0 + 2], -31
clc
lock adc dword [rdx + 8 * 1 + 0], -31
clc
lock adc qword [rdx + 8 * 2 + 0], -31

stc
lock adc word [rdx + 8 * 0 + 4], -31
stc
lock adc dword [rdx + 8 * 1 + 0], -31
stc
lock adc qword [rdx + 8 * 2 + 0], -31

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt