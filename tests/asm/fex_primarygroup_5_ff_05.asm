; BITS: 64
; SOURCE: FEX PrimaryGroup/5_FF_05.asm
; FEX_SHA256: 3deb276edb01ef2ee35a5c7d8652413b94764a3a0a35b5bbb333dffbc32ae0d3
mov rsp, 0xe000_1000
mov ax, cs
lea edi, [rel .success]

sub rsp, 16
mov [rsp], edi
mov [rsp+4], cs

mov rax, 0
jmp far [rsp]

hlt

.success:
mov rax, 1
hlt