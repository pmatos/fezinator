; BITS: 64
; SOURCE: FEX TwoByte/0F_74.asm
; FEX_SHA256: 01bbe4beb39dba02f1e81bb993b55bbf7dc273b96bfb36b8da2c77095a09b8e6
mov rdx, 0xe0000000

mov rax, 0x7172737475767778
mov [rdx + 8 * 0], rax
mov rax, 0x4142434445464748
mov [rdx + 8 * 1], rax

mov rax, 0x6162636465666778
mov [rdx + 8 * 2], rax
mov rax, 0x5152535455565748
mov [rdx + 8 * 3], rax

movq mm0, [rdx]
pcmpeqb mm0, [rdx + 8 * 2]

movq mm1, [rdx]
movq mm2, [rdx + 8 * 2]
pcmpeqb mm1, mm2

hlt