; BITS: 64
; SOURCE: FEX Primary/Primary_A5_dword_REP.asm
; FEX_SHA256: 782f48b95dec5f6e2eeb21c79d71a592a33540faa71a8b4ae31a60d9e0677f19
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rdi, [rdx + 8 * 2]
lea rsi, [rdx + 8 * 0]

cld
mov rcx, 2
rep movsd ; rdi <- rsi

mov rax, [rdx + 8 * 2]
mov rdx, [rdx + 8 * 3]
hlt