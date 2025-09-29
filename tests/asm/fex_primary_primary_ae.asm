; BITS: 64
; SOURCE: FEX Primary/Primary_AE.asm
; FEX_SHA256: c92907c1bfe463b874a353012f7bf3d179df47490cf14da940397ea7f7045127
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax

lea rdi, [rdx + 8 * 0]

cld
mov rax, 0x61
scasb
; cmp = 0x61 - 0x48 = 0x19
; 0: CF - 00000000
; 1:    - 00000010
; 2: PF - 00000000
; 3:  0 - 00000000
; 4: AF - 00010000
; 5:  0 - 00000000
; 6: ZF - 00000000
; 7: SF - 00000000
; ================
;         00010010
; OF: LAHF doesn't load - 0

mov rax, 0
lahf

hlt