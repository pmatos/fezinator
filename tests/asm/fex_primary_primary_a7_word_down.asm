; BITS: 64
; SOURCE: FEX Primary/Primary_A7_word_down.asm
; FEX_SHA256: 6eb79b22e97464effed292f4c27bcf077610c20090822db062217b1fe2d05480
mov rdx, 0xe0000000

mov rax, 0x6162
mov [rdx + 8 * 0], rax
mov rax, 0x4546
mov [rdx + 8 * 1], rax

lea rdi, [rdx + 8 * 1]
lea rsi, [rdx + 8 * 0]

std
cmpsw ; rdi cmp rsi
; cmp = 0x4546 - 0x6162 = 0xE3E4
; 0: CF - 00000001
; 1:    - 00000010
; 2: PF - 00000100
; 3:  0 - 00000000
; 4: AF - 00000000
; 5:  0 - 00000000
; 6: ZF - 00000000
; 7: SF - 10000000
; ================
;         10000111
; OF: LAHF doesn't load - 0

mov rax, 0
lahf

hlt