; BITS: 64
; SOURCE: FEX Primary/Primary_A9.asm
; FEX_SHA256: 3f4cbb8f3f99a6a39661dae61f475a5b5cd638018ff7c548388b30be327b3e73
mov rax, 0x6162636465666768
test rax, 0x71727374
; test = 0x6162636465666768 & 0x71727374 = 0x61626360
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
mov rcx, rax
and rcx, 0xffffffffffffefff

mov rax, 0x5152535455565758
test eax, 0x71727374
; test = 0x55565758 & 0x71727374 = 0x51525350
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
mov rbx, rax
and rbx, 0xffffffffffffefff

mov rax, 0x4142434445464748
test ax, 0x7172
; test = 0x4748 & 0x7172 = 0x4140
; 0: CF - 00000000
; 1:    - 00000010
; 2: PF - 00000000
; 3:  0 - 00000000
; 4: AF - 00000000 <- Undefined
; 5:  0 - 00000000
; 6: ZF - 00000000
; 7: SF - 00000000
; ================
;         00000010
; OF: LAHF doesn't load - 0

mov rax, 0
lahf
and rax, 0xffffffffffffefff

hlt