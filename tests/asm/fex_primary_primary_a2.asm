; BITS: 64
; SOURCE: FEX Primary/Primary_A2.asm
; FEX_SHA256: 6863d309951fc3716d9137b4767128a56794f1295a8886721b0ca10b89c89b0b
mov rax, 0x41
; mov [0xe0000008], rax
db 0x48
db 0xA3
dq 0x00000000e0000008

mov rax, 0x42
; mov [0xe0000000], eax
db 0x67
db 0xA3
dd 0xe0000000

mov rdx, 0xe0000008
mov rax, [rdx]

mov rdx, 0xe0000000
mov edx, [rdx]

hlt