; BITS: 64
; SOURCE: FEX Primary/Primary_AD_REPNE_word_down.asm
; FEX_SHA256: c684ada36a12c013ae7b7b1a938267b2cbc1918c19c9925b36f2775361dbe21f
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rsi, [rdx + 8 * 2]

std
mov rax, 0xFF
mov rcx, 8
repne lodsw

hlt