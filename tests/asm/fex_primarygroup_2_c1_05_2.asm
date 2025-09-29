; BITS: 64
; SOURCE: FEX PrimaryGroup/2_C1_05_2.asm
; FEX_SHA256: 0af8d442cfaadfed7576b5b07242ef50190a3314ba09b82159cbef5340815772
mov rax, 0
mov rbx, 0xA142434445464748
shr rbx, 62
lahf
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

; Mask out AF since it is undefined
and rax, ~0x1000

hlt