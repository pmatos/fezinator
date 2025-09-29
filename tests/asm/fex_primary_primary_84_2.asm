; BITS: 64
; SOURCE: FEX Primary/Primary_84_2.asm
; FEX_SHA256: 7495a43a4a896eaf718759b8030fb02f42fe04bff59bce8dd4f4adb3ef3393b3
mov rdx, 0xe0000000
mov dword [rdx], 0xFFFFFF00

mov     r11d, dword[rdx]
test    r11b, r11b
jnz     notzero

mov rax, 0x0
hlt

notzero:
mov rax, 0x1
hlt