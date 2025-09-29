; BITS: 64
; SOURCE: FEX Primary/Primary_6A.asm
; FEX_SHA256: 2b4e46a9934b47d4cfcd7ab9be9099071e560f437ce33fe917c28ddd182b3dec
mov rsp, 0xe0000020

push -127
mov rdx, 0xe0000020
mov rax, [rdx - 8]

hlt