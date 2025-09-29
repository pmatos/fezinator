; BITS: 64
; SOURCE: FEX x87_stack.asm
; FEX_SHA256: 15c19152a2b4f4cce885f12e36de44c91060bc52b69806e2770615be3ef55134
lea rax, [rel .data]
lea rbx, [rel .data_mov]

fld qword [rax]
fstp qword [rbx]

mov rax, [rbx]
mov rbx, [rbx + 8]
hlt

.data:
dq 0x4142434445464748
dq 0x5152535455565758

.data_mov:
dq 0
dq 0