; BITS: 64
; SOURCE: FEX PrimaryGroup/1_80_07.asm
; FEX_SHA256: 881c5e00437ca4ccff87e704313d7f9ebd41f4c876f0650f1c33d19956984a09
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

cmp byte [rdx + 8 * 0 + 1], 0x61
; cmp = 0x47 - 0x61 = 0xE6
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
mov rax, [rdx + 8 * 0]
lahf

hlt