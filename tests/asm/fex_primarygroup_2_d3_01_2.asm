; BITS: 64
; SOURCE: FEX PrimaryGroup/2_D3_01_2.asm
; FEX_SHA256: baeaeef50491972f23d8633e1ff06dc613850dd8f02030add2b2ebc5a14e865f
mov r15, 1

; Should all set carry
;8bit
mov rax, 0x80

mov cl, 8
ror al, cl

mov r14, 0
cmovc r14, r15

; 16bit
mov rax, 0x8000

mov cl, 16
ror ax, cl

mov r13, 0
cmovc r13, r15

; 32bit
mov rax, 0x40000000

mov cl, 31
ror eax, cl

mov r12, 0
cmovc r12, r15

; 64bit
mov rax, 0x4000000000000000

mov cl, 63
ror rax, cl

mov r11, 0
cmovc r11, r15

; Shouldn't set carry

;8bit
clc
mov rax, 0x80

mov cl, 0
ror al, cl

mov r10, 0
cmovc r10, r15

; 16bit
clc
mov rax, 0x8000

mov cl, 0
ror ax, cl

mov r9, 0
cmovc r9, r15

; 32bit
clc
mov rax, 0x80000000

mov cl, 0
ror eax, cl

mov r8, 0
cmovc r8, r15

; 64bit
clc
mov rax, 0x8000000000000000

mov cl, 0
ror rax, cl

mov rsp, 0
cmovc rsp, r15

hlt