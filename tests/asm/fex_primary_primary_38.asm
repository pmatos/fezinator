; BITS: 64
; SOURCE: FEX Primary/Primary_38.asm
; FEX_SHA256: db853f02c978d50e7ecbdc9f2be54b422ad90d88a91c4800aad9126530bcd09b
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, 0x61
cmp byte [rdx + 8 * 0 + 1], al
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