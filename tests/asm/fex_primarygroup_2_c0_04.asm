; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C0_04.asm
; FEX_SHA256: 23a48a1cdadc8fec05c98b844869633cf5779450ac8faa77297f03ee02170435
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

shl byte [rdx + 8 * 0 + 1], 0x61

mov rax, [rdx + 8 * 0]

hlt