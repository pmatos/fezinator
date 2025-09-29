; BITS: 64
; SOURCE: FEX Primary/Primary_3A.asm
; FEX_SHA256: e061bf6e8618ecf1863923ba586b186afc96840484032972bb65704e4b5d5396
mov rdx, 0xe0000000

mov rax, 0x4142434445466148
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov rax, 0x47
cmp al, byte [rdx + 8 * 0 + 1]
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