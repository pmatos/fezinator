; BITS: 64
; SOURCE: FEX Primary/Primary_AE_REPNE.asm
; FEX_SHA256: 69a68ab6b2985eee184d03d88d8848d0ddeb5d5843dd5071fc34e05242d51446
mov rdx, 0xe0000000

mov rax, 0x4161434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax

lea rdi, [rdx + 8 * 0]

cld
mov rax, 0x61
mov rcx, 8
cmp rax, 0

repne scasb

hlt