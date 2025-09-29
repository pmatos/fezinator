; BITS: 64
; SOURCE: FEX Primary/Primary_AB_word_REPNE.asm
; FEX_SHA256: 655722516e40f027467631dcc8125133533835493ff66a1c0bae1b9cb978c608
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2]

cld
mov rcx, 0x4
mov rax, 0xF1F2
repne stosw ; rdi <- ax

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt