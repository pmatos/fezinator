; BITS: 64
; SOURCE: FEX Primary/Primary_AD_REPNE_word.asm
; FEX_SHA256: 0ebd6fe630ff379883ee9cc70911edfb34c4e11e6dfafb62013b151c36bde344
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rsi, [rdx + 8 * 0]

cld
mov rax, 0xFF
mov rcx, 8
repne lodsw

hlt