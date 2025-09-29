; BITS: 64
; SOURCE: FEX Primary/Primary_C2.asm
; FEX_SHA256: 9c1e23ad5a54a957be276338f870931d4a1ccdad59da08f2f084ff11efcd5cae
mov rsp, 0xe0000020
lea rax, [rel .end]
push rax

mov rax, 1
ret 0xFF00
mov rax, 0

.end:
hlt