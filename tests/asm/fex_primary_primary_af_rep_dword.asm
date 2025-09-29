; BITS: 64
; SOURCE: FEX Primary/Primary_AF_REP_dword.asm
; FEX_SHA256: 04b5961169691b855696eb390809d1dfc6e5f712c16782f6cd3a7e8bcbc481bd
mov rdx, 0xe0000000

mov rax, 0x4142434461626364
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax

lea rdi, [rdx + 8 * 0]

cld
mov rax, 0x61626364
mov rcx, 8
cmp rax, 0x61626364

rep scasd

hlt