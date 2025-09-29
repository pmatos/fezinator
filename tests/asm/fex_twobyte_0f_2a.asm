; BITS: 64
; SOURCE: FEX TwoByte/0F_2A.asm
; FEX_SHA256: 2a0c6b4b0793f44f6da5adac4700c7b17725ba66a330292d7f4b28c92d5dc7a1
mov rdx, 0xe0000000

mov rax, 0x0000000100000002
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x7172737475767778
mov [rdx + 8 * 3], rax

movq mm0, [rdx + 8 * 0]
movaps xmm0, [rdx + 8 * 2]

cvtpi2ps xmm0, mm0

hlt