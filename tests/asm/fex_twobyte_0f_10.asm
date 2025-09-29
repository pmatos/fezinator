; BITS: 64
; SOURCE: FEX TwoByte/0F_10.asm
; FEX_SHA256: 6840249d1749689b044b0a10442ec2e6478f15fdaa6989a5a450a588706cdc38
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

movups xmm0, [rdx + 8 * 0]

hlt