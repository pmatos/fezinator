; BITS: 64
; SOURCE: FEX Primary/Primary_8C_2.asm
; FEX_SHA256: 6b8dd811433b722316bb6d269b9a005e170a23481131d6228c782dddf24eee34
; This relies on some behaviour that isn't guaranteed in 64bit mode

; Technically this can result in an invalid selector which can cause faults
; We currently don't do any selector validation to enforce this
mov rax, 0x4142

db 0x44 ; REX.R
mov es, ax

inc rax

db 0x44 ; REX.R
mov ss, ax

inc rax

db 0x44 ; REX.R
mov ds, ax

; Can't test FS/GS here
; Behaviour is ill-defined and needs to be worked through

mov rax, 0
mov rbx, 0
mov rcx, 0

db 0x44 ; REX.R
mov ax, es

db 0x44 ; REX.R
mov bx, ss

db 0x44 ; REX.R
mov cx, ds

hlt