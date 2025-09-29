; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D0_07.asm
; FEX_SHA256: c9d1f1390a9dce8e48e16772773c168574171bf32c59370a83bd730f98d3f8ba
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

sar byte [rdx + 8 * 0 + 1], 1

mov rax, [rdx + 8 * 0]

hlt