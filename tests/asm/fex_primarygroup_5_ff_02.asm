; BITS: 64
; SOURCE: FEX PrimaryGroup/5_FF_02.asm
; FEX_SHA256: d577d6a2ec44dc45843494eecf43d84fa5865110df5d5dfc568d2c707fa8aa29
mov r15, 0xe0000000
lea rsp, [r15 + 8 * 4]

mov rax, 0x4142434445464748
mov [r15 + 8 * 0], rax
mov rax, 0x5152535455565758
mov [r15 + 8 * 1], rax

lea rbx, [rel .call_tgt]
mov [r15 + 8 * 2], rbx

mov rax, 0
call qword [r15 + 8 * 2]
jmp .end

.call_tgt:
mov rax, [r15 + 8 * 0]
ret

; Couple things that could catch failure
mov rax, 0
jmp .end
mov rax, 0

.end:
hlt