; BITS: 64
; SOURCE: FEX PrimaryGroup/1_81_03_2.asm
; FEX_SHA256: 3764cd128f5b778cfe38bbab62ce3f7ec3cd92385976bf545ce3aa8037c791fb
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 3], rax

clc
lock sbb  word [rdx + 8 * 0 + 2], 0x6162
clc
lock sbb dword [rdx + 8 * 1 + 0], 0x61626364
clc
lock sbb qword [rdx + 8 * 2 + 0], 0x61626364
clc
lock sbb qword [rdx + 8 * 3 + 0], -256

stc
lock sbb  word [rdx + 8 * 0 + 4], 0x6162
stc
lock sbb dword [rdx + 8 * 1 + 0], 0x61626364
stc
lock sbb qword [rdx + 8 * 2 + 0], 0x61626364
stc
lock sbb qword [rdx + 8 * 3 + 0], -256

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]

hlt