; BITS: 64
; SOURCE: FEX Primary/Primary_AD_REPNE_dword_down.asm
; FEX_SHA256: 502b08bf9d0dfe141a72d61f923c2864eb8618889742979eca5e0f18a5124f4b
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x7172737475767778
mov [rdx + 8 * 3], rax
mov rax, 0x0
mov [rdx + 8 * 4], rax

lea rsi, [rdx + 8 * 4]

std
mov rax, 0xFF
mov rcx, 8
repne lodsd

hlt