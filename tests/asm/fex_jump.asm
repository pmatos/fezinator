; BITS: 64
; SOURCE: FEX jump.asm
; FEX_SHA256: cc0c9081bcc99aedcafefa1158d6bf725d4733849adc11c0f8c38a234da523b7
mov esi, 50

.jump_start:
mov edi, 1
test edi, edi
nop
nop
nop
nop
nop
nop
nop
nop

jz .local
mov eax, 1
jmp .end

.local:
mov eax, 0

.end:
sub esi, 1
test esi, esi
jz .jump_start
hlt