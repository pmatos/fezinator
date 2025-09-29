; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C1_05.asm
; FEX_SHA256: c6a4fada8c283c8cbb98640041466ff44a1fad6f0f223aff0c9eb6629118f1d1
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

shr  word [rdx + 8 * 0 + 2], 0x62
shr dword [rdx + 8 * 1 + 0], 0x62
shr qword [rdx + 8 * 2 + 0], 0x62

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]

hlt