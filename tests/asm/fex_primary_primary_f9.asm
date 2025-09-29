; BITS: 64
; SOURCE: FEX Primary/Primary_F9.asm
; FEX_SHA256: c4c7c41a2c38e76ac5177434992d685a3e2946c846360ce9b3adbba7406368d8
stc

; Get CF
sbb rax, rax
and rax, 1

hlt