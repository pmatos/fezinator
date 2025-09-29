; BITS: 64
; SOURCE: FEX Primary/Primary_E8.asm
; FEX_SHA256: 5f36bc3e6c27aaa96d3cbed735d6c7f27fac45e663ff1569bd6126ebcc899596
mov rsp, 0xe0000020
mov rax, 0
mov rbx, 0

; NASM doesn't have a way to explicitly encode a 16bit or 32bit relative call
; Manually encode
db 0x66 ; 16bit
db 0xE8 ; CALL
db 0x02 ; +0x0002 (Just past the next JUMP instruction
db 0x00

jmp .end1

.target1:
mov rax, 1
ret

.end1:

; NASM doesn't have a way to explicitly encode a 16bit or 32bit relative call
; Manually encode
db 0xE8 ; CALL
db 0x02 ; +0x00000002 (Just past the next JUMP instruction
db 0x00
db 0x00
db 0x00

jmp .end2

.target2:
mov rbx, 1
ret

.end2:
hlt