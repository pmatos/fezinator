; BITS: 64
; SOURCE: FEX PrimaryGroup/1_81_07.asm
; FEX_SHA256: 416231a0f4aeb6dfff2e249ae463dd920ee0d6337fdb90a44705868f8a0934ff
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 3], rax

cmp qword [rdx + 8 * 3 + 0], -256
; cmp = 0x6162636465666768 - -256(0xFFFFFFFFFFFF00) = 0x6162636465666512
; 0: CF - 00000001
; 1:    - 00000010
; 2: PF - 00000000
; 3:  0 - 00000000
; 4: AF - 00000000
; 5:  0 - 00000000
; 6: ZF - 00000000
; 7: SF - 00000000
; ================
;         00000011
; OF: LAHF doesn't load - 0
mov rax, 0
lahf
mov rsi, rax

cmp qword [rdx + 8 * 2 + 0], 0x61626364
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
mov rcx, rax

cmp dword [rdx + 8 * 1 + 0], 0x61626364
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
mov rbx, rax

cmp word [rdx + 8 * 0 + 2], 0x6162
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