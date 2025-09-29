; BITS: 64
; SOURCE: FEX Primary/Primary_9E.asm
; FEX_SHA256: 47a983e2e4b65a55db38262434b4ebf0c5f3763d6e8ae64c9de5725db13b7519
; Set EFLAGS to known value with sahf
mov rax, -1
sahf

; Now load back
mov rax, -1
lahf
; 0: CF - 00000001
; 1:    - 00000010
; 2: PF - 00000100
; 3:  0 - 00000000
; 4: AF - 00010000
; 5:  0 - 00000000
; 6: ZF - 01000000
; 7: SF - 10000000
; ================
;         11010111
; OF: LAHF doesn't load - 0

hlt