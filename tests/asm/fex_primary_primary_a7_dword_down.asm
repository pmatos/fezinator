; BITS: 64
; SOURCE: FEX Primary/Primary_A7_dword_down.asm
; FEX_SHA256: cb65f4b385b7e800ba4a1864c29a0d38bd1c9b4f2ebc66661cbf8aac2dcead81
mov rdx, 0xe0000000

mov rax, 0x61626364
mov [rdx + 8 * 0], rax
mov rax, 0x55565758
mov [rdx + 8 * 1], rax

lea rdi, [rdx + 8 * 1]
lea rsi, [rdx + 8 * 0]

std
cmpsd ; rdi cmp rsi
; cmp = 0x55565758 - 0x61626364 = 0xF3F3F3F4
; 0: CF - 00000001
; 1:    - 00000010
; 2: PF - 00000000
; 3:  0 - 00000000
; 4: AF - 00000000
; 5:  0 - 00000000
; 6: ZF - 00000000
; 7: SF - 10000000
; ================
;         10000011
; OF: LAHF doesn't load - 0
mov rax, 0
lahf

hlt