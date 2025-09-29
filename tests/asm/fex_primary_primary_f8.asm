; BITS: 64
; SOURCE: FEX Primary/Primary_F8.asm
; FEX_SHA256: b85c64cda62a0448fef7989450a879a8179603b671a0553ec83610c6ad13bb8e
clc

; Get CF
sbb rax, rax
and rax, 1

hlt