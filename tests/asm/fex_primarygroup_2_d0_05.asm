; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D0_05.asm
; FEX_SHA256: b9669f74b59e1f3af6a3e71361d02dd78fcde6dfe2dc1d66b37fbfd9f9348ab3
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

shr byte [rdx + 8 * 0 + 1], 1

mov rax, [rdx + 8 * 0]

hlt