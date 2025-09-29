; BITS: 64
; SOURCE: FEX TwoByte/0F_89.asm
; FEX_SHA256: 0224eb7fddfea6195421deb463b50b581787acbe0dba5a4fe6030934a147dbbf
mov r15, 0xe0000000

mov r10, 0x1
mov r11, 0x0
mov r12, 0x1

cmp r10d, r12d

mov rax, 0
mov rbx, 0

jns .tgt_1
js .tgt_2
jmp .end

.tgt_1:
mov rax, 1
jmp .end

.tgt_2:
mov rbx, 1
jmp .end

.end:
hlt