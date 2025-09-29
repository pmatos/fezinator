; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D0_01.asm
; FEX_SHA256: 07acb2cc80c0bf782bed53fd2148aa6243d8d23bed2a81ee7262aece59e77da5
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

ror byte [rdx + 8 * 0 + 1], 1

mov rax, [rdx + 8 * 0]

hlt