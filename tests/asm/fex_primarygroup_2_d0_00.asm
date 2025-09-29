; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D0_00.asm
; FEX_SHA256: ffc2d213a98e803c61c78e5e771fbb25a0d0e8dbc6212e33e7ca9be8df160522
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

rol byte [rdx + 8 * 0 + 1], 1

mov rax, [rdx + 8 * 0]

hlt