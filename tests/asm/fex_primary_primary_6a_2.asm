; BITS: 64
; SOURCE: FEX Primary/Primary_6A_2.asm
; FEX_SHA256: ca27d7603a6a2682f75bce4df633d7bf0ddce77bfe0390920ebf14da1df30895
mov rsp, 0xe0000020

push word 0
push word 0
push word 0
push word -127

mov rdx, 0xe0000020
mov rax, [rdx - 8]

hlt