; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F6_00.asm
; FEX_SHA256: b3e2076ccf570431c1f367301b7f6f285711f84d4506e0913a3a075fb2e87d49
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

test byte [rdx + 8 * 0 + 1], 0x61
; test = 0x47 & 0x61 = 0x41
; 0: CF - 00000000
; 1:    - 00000010
; 2: PF - 00000100
; 3:  0 - 00000000
; 4: AF - 00000000 <- Undefined
; 5:  0 - 00000000
; 6: ZF - 00000000
; 7: SF - 00000000
; ================
;         00000110
; OF: LAHF doesn't load - 0

mov rax, 0
lahf

hlt