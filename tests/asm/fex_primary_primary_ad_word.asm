; BITS: 64
; SOURCE: FEX Primary/Primary_AD_word.asm
; FEX_SHA256: ae3f6ee819a67a55d18fa823c521ee6a7441523ff9cff1a3777c8f71f9839053
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
lodsw
lodsw
lodsw
lodsw

lodsw
lodsw
lodsw
lodsw

hlt