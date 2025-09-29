; BITS: 64
; SOURCE: FEX TwoByte/0F_6B.asm
; FEX_SHA256: 232e72dec94a9d2628f03d753b070d6839b8592ee805f1d6beed3bfd8b087bbf
mov rdx, 0xe0000000

; 32bit signed -> 16bit signed (saturated)
; input > 0x7FFF(SHRT_MAX, 32767) = 0x7FFF(SHRT_MAX, 32767)
; input < 0x8000(-32767) = 0x8000

mov rax, 0xFFFFFFFF80000000
mov [rdx + 8 * 0], rax
mov rax, 0x0000000000000040
mov [rdx + 8 * 1], rax

mov rax, 0xFFFFFFFF80000000
mov [rdx + 8 * 2], rax
mov rax, 0x0000000000000040
mov [rdx + 8 * 3], rax

movq mm0, [rdx]
packssdw mm0, [rdx + 8 * 2]

movq mm1, [rdx]
movq mm2, [rdx + 8 * 2]
packssdw mm1, mm2

hlt