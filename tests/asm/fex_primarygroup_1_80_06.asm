; BITS: 64
; SOURCE: FEX PrimaryGroup/1_80_06.asm
; FEX_SHA256: 65c2f7511e91096def9a720063117a13f56a19f48711500a332aa853804b9824
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

xor byte [rdx + 8 * 0 + 1], 0x61
mov rax, [rdx + 8 * 0]

hlt