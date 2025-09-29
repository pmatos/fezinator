; BITS: 64
; SOURCE: FEX Primary/Primary_AC_REPNE.asm
; FEX_SHA256: 35d80ea6f98d43537dbf17d835b96ee5c95fbddb2deec9cf6db7330b2c7c8ef5
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
repne lodsb

hlt