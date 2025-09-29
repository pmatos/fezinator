; BITS: 64
; SOURCE: FEX PrimaryGroup/1_83_07.asm
; FEX_SHA256: c6d30a322917513b2e6ad9acdebfccdc092734b6bbbefbed4d15eb7a6d74fd4d
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

cmp qword [rdx + 8 * 2 + 0], -31
; cmp = 0x6162636465666768 - -31 = 0x6162636465666787
; 0: CF - 00000001
; 1:    - 00000010
; 2: PF - 00000100
; 3:  0 - 00000000
; 4: AF - 00000000
; 5:  0 - 00000000
; 6: ZF - 00000000
; 7: SF - 00000000
; ================
;         00000111
; OF: LAHF doesn't load - 0
mov rax, 0
lahf
mov rcx, rax

cmp dword [rdx + 8 * 1 + 0], -31
; cmp = 0x55565758 - -31 = 0x55565777
; 0: CF - 00000001
; 1:    - 00000010
; 2: PF - 00000100
; 3:  0 - 00000000
; 4: AF - 00000000
; 5:  0 - 00000000
; 6: ZF - 00000000
; 7: SF - 00000000
; ================
;         00000111
; OF: LAHF doesn't load - 0
mov rax, 0
lahf
mov rbx, rax

cmp word [rdx + 8 * 0 + 2], -31
; cmp = 0x4546 - -31 = 0x4577
; 0: CF - 00000001
; 1:    - 00000010
; 2: PF - 00000100
; 3:  0 - 00000000
; 4: AF - 00000000
; 5:  0 - 00000000
; 6: ZF - 00000000
; 7: SF - 00000000
; ================
;         00000111
; OF: LAHF doesn't load - 0
mov rax, 0
lahf

hlt