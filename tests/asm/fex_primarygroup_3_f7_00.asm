; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F7_00.asm
; FEX_SHA256: 2a9c5ea18be8b2b52a4df6a0e828efc83c8ad8351f72b8cde28e60b0cfd22025
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

test qword [rdx + 8 * 2], 0x71727374
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

test dword [rdx + 8 * 1], 0x71727374
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

test word [rdx + 8 * 0], 0x7172
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