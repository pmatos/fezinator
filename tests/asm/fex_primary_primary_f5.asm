; BITS: 64
; SOURCE: FEX Primary/Primary_F5.asm
; FEX_SHA256: 89e1943e274fa8fc0b6ba84e99b614bc523d7211033bd80bcec528e56661b328
; Set CF to known value
clc

cmc

; Get CF
sbb rax, rax
and rax, 1

hlt