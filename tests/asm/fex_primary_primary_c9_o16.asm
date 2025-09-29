; BITS: 64
; SOURCE: FEX Primary/Primary_C9_o16.asm
; FEX_SHA256: 5f38bcaaff1c0ac69ed8f3ec574aa5975483256987196715e5647232e7e9a7a9
mov rsp, 0xe0000020
mov rbp, 0x4142434445464748

; Act like an ENTER frame without using ENTER
sub rsp, 2
mov [rsp], bp
mov rbp, rsp
call .target
jmp .end

.target:
mov rax, 1
o16 leave

.end:
hlt