; BITS: 64
; SOURCE: FEX TwoByte/0F_8C.asm
; FEX_SHA256: 7500debe6d5b51e94f91fd6ef5a80677e0eb59d52c79469af61bfd895bea2c2b
mov r15, 0xe0000000

mov r10, 0x1
mov r11, 0x0
mov r12, 0x2

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jl .tgt_1
jnl .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt