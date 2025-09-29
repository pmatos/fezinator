; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C0_07_2.asm
; FEX_SHA256: 8720ef337f713e62700939891c9363865172dc174a36127a17149cce7aec2296
mov rax, 0
mov rbx, 0xA142434445464748
sar rbx, 62
lahf
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

; Mask out AF since it is undefined
and rax, ~0x1000

hlt