; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F6_07_2.asm
; FEX_SHA256: 4a8bc148b3e2794482f3b853b4741467a3c8feef2440cb31651355869bb57e33
mov rdx, 0xe0000000

mov rax, 0x8
mov [rdx + 8 * 0], rax

; Test that 8bit divide divides a 16bit dividend
mov ax, 0x0108
idiv byte [rdx + 8 * 0]

hlt