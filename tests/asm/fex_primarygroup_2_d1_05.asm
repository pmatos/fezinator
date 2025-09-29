; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D1_05.asm
; FEX_SHA256: 190cb99a7b3c0fa3a0217da5af7b0ae4023310bc842786fab6072ec1da674798
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

shr  word [rdx + 8 * 0 + 2], 1
shr dword [rdx + 8 * 1 + 0], 1
shr qword [rdx + 8 * 2 + 0], 1

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt