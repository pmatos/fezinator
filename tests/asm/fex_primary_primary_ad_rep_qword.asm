; BITS: 64
; SOURCE: FEX Primary/Primary_AD_REP_qword.asm
; FEX_SHA256: aa99ca817d525702e1a1e6318f01555bd6bbd8533310465856ed965f31cf1458
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x7172737475767778
mov [rdx + 8 * 3], rax
mov rax, 0x8182838485868788
mov [rdx + 8 * 4], rax
mov rax, 0x9192939495969798
mov [rdx + 8 * 5], rax
mov rax, 0xA1A2A3A4A5A6A7A8
mov [rdx + 8 * 6], rax
mov rax, 0xB1B2B3B4B5B6B7B8
mov [rdx + 8 * 7], rax
mov rax, 0x0
mov [rdx + 8 * 8], rax

lea rsi, [rdx + 8 * 0]

cld
mov rax, 0xFF
mov rcx, 8
rep lodsq

hlt