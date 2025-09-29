; BITS: 64
; SOURCE: FEX Primary/Primary_3B.asm
; FEX_SHA256: 31cee4faf794c1e54e9d758414cddb9b886a58dcac215ad7e5a88ea5c01c368d
mov rdx, 0xe0000000

mov rax, 0x61620000
mov [rdx + 8 * 0], rax
mov rax, 0x61626364
mov [rdx + 8 * 1], rax
mov rax, 0x61626364
mov [rdx + 8 * 2], rax
mov rax, -256
mov [rdx + 8 * 3], rax

mov rax, 0x6162636465666768
cmp rax, qword [rdx + 8 * 3 + 0]
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

mov rax, 0x6162636465666768
cmp rax, qword [rdx + 8 * 2 + 0]
; cmp = 0x6162636465666768 - 0x61626364 = 0x6162636404040404
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

mov rax, 0x5152535455565758
cmp eax, dword [rdx + 8 * 1 + 0]
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

mov rax, 0x0000414243444546
cmp ax, word [rdx + 8 * 0 + 2]
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