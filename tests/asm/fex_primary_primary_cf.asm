; BITS: 64
; SOURCE: FEX Primary/Primary_CF.asm
; FEX_SHA256: 6ce8464ae10d5683fe0b11b2682c86e5d3a2a3fc584c4f5b6b84b089f2b41197
mov esp, 0xe0000030

lea rbx, [rel .end]
mov rcx, 0x33
mov rdx, rsp

mov eax, 0x2b
push rax ; SS
push rdx ; RSP
mov eax, 0x202
push rax ; RFLAGS
push rcx ; CS
push rbx ; RIP

mov eax, -1
iretq

; Super fail
mov eax, 2
hlt

.end_fail:
mov eax, 0
hlt

.end:
mov eax, 1

hlt