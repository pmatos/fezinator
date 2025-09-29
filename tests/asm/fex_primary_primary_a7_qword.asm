; BITS: 64
; SOURCE: FEX Primary/Primary_A7_qword.asm
; FEX_SHA256: 58898bf5c56d5f7f235fb25462293d2b11036647dec0c2d91f43874c97084cb4
mov rdx, 0xe0000000

mov rax, 0x0000000061626364
mov [rdx + 8 * 0], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 1], rax

lea rdi, [rdx + 8 * 1]
lea rsi, [rdx + 8 * 0]

cld
cmpsq ; rdi cmp rsi
; cmp = 0x6162636465666768- 0x61626364 = 0x6162636404040404
; 0: CF - 00000000
; 1:    - 00000010
; 2: PF - 00000000
; 3:  0 - 00000000
; 4: AF - 00000000
; 5:  0 - 00000000
; 6: ZF - 00000000
; 7: SF - 00000000
; ================
;         00000010
; OF: LAHF doesn't load - 0

mov rax, 0
lahf

hlt