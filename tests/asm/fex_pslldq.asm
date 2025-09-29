; BITS: 64
; SOURCE: FEX pslldq.asm
; FEX_SHA256: 41e0c09e9bc364d62fb5298f4169d982dd52872824c4abbbe6b01fedabd9fa20
mov rdx, 0xe8000000
mov rax, 0xDEADBEEFBAD0DAD1
mov rcx, 0x4141414141414141

mov [rdx], rax
mov [rdx + 8], rcx

movups xmm0, [rdx]
pslldq xmm0, 1

movups xmm1, [rdx]
psrldq xmm1, 1

hlt