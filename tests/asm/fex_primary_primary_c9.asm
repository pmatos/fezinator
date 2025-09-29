; BITS: 64
; SOURCE: FEX Primary/Primary_C9.asm
; FEX_SHA256: fb07e025b0df52aaeecfcef32559e522428382b8e9cbb8baa6f872c7a7bae280
mov rsp, 0xe0000020
mov rbp, 0x4142434445464748

; Act like an ENTER frame without using ENTER
push rbp
mov rbp, rsp
call .target
jmp .end

.target:
mov rax, 1
leave

.end:
hlt