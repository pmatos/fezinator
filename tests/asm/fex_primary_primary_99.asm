; BITS: 64
; SOURCE: FEX Primary/Primary_99.asm
; FEX_SHA256: 69ea1ce4fc704ae9739ea821c643156fbd5d9b8ee3f33a1b81b8d7f838061add
mov rax, 0
mov rdx, 0

mov ax, 0xFFF0
cwd

shl edx, 16
or eax, edx
cdq

shl rdx, 32
or rax, rdx
cqo

hlt