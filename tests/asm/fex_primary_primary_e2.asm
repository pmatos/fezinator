; BITS: 64
; SOURCE: FEX Primary/Primary_E2.asm
; FEX_SHA256: e265ca9230f980173b05b20b6a09f28f83cea16fa3a17b2c1c713acca114717b
mov rax, 0
mov rcx, 0x11

jmp .head

.top:

add rax, 1

.head:

loop .top

hlt