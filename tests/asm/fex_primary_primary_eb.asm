; BITS: 64
; SOURCE: FEX Primary/Primary_EB.asm
; FEX_SHA256: cc811257a4d39187df82d85b7a62ba189c278d347a889050e4596e9fda06e91f
mov rsp, 0xe0000020
mov rax, 0

; NASM doesn't have a way to explicitly encode a 16bit or 32bit relative jump
; Manually encode
db 0xEB ; JUMP
db 0x02 ; +0x02 (Just past the next JUMP instruction

.back:
jmp .end

.target:
mov rax, 1
jmp .back

.end:
hlt