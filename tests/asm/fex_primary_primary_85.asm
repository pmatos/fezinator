; BITS: 64
; SOURCE: FEX Primary/Primary_85.asm
; FEX_SHA256: 99173044c68e2ecd1acbf9778739a5c391d89b3ac375eecd14247f99c62e9b08
mov rax, 0x6162636465666768
mov rdx, 0x71727374
test rax, rdx
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
mov rdx, 0x71727374
test eax, edx
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
mov rdx, 0x7172
test ax, dx
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