; BITS: 64
; SOURCE: FEX Primary/Primary_C3.asm
; FEX_SHA256: 4ee0dca786d2fa4f228c095f31af44494aa2f7ef167d54c7d5cda6dbe2ff6e7d
mov rsp, 0xe0000020
lea rax, [rel .end]
push rax

mov rax, 1
ret
mov rax, 0

.end:
hlt