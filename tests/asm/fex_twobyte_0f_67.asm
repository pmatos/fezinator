; BITS: 64
; SOURCE: FEX TwoByte/0F_67.asm
; FEX_SHA256: 49ae33d4d5580ced6465360206a5d024a763ddbdf2c2d45dfc9c912dad69b5e1
mov rdx, 0xe0000000

; 16bit signed -> 8bit unsigned (saturated)
; input > 0x7F(SCHAR_MAX, 127) = 0xFF(UCHAR_MAX, 255)
; input < 0x00(Negative) = 0x0

mov rax, 0x0000FFFF007F0041
mov [rdx + 8 * 0], rax
mov rax, 0x0000FFFF007F0041
mov [rdx + 8 * 1], rax

mov rax, 0x0000FFFF007F0041
mov [rdx + 8 * 2], rax
mov rax, 0x0000FFFF007F0041
mov [rdx + 8 * 3], rax

movq mm0, [rdx]
packuswb mm0, [rdx + 8 * 2]

movq mm1, [rdx]
movq mm2, [rdx + 8 * 2]
packuswb mm1, mm2

hlt