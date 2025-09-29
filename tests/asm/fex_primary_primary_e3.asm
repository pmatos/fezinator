; BITS: 64
; SOURCE: FEX Primary/Primary_E3.asm
; FEX_SHA256: af6abb888ba36deb3b38a10f8023d793fbe543369b07b8e0dc120297140b4565
mov rax, 0
mov rcx, 0x10

jmp .head

.top:

add rax, 1
sub rcx, 1

.head:

jrcxz .next
jmp .top
.next:

; Second test
mov rbx, 0
mov rcx, 0xFFFFFFFF00000010
jmp .head2

.top2:
add rbx, 1
sub rcx, 1

.head2:
jecxz .next2
jmp .top2

.next2:

hlt