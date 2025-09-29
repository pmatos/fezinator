; BITS: 64
; SOURCE: FEX fadd.asm
; FEX_SHA256: ae469ee8b805c8198e77b02fba29c06a21c8bfd288754e1d49dc4a7bb2008bff
; calcuate pi + pi
fld dword [rel pi]
fld dword [rel pi]
faddp

hlt

align 8
pi:     dd 0x40490fdb ; 3.14...
one:    dd 0x3f800000 ; 1.0
ptone:  dd 0x3dcccccd ; 0.1