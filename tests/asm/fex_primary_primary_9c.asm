; BITS: 64
; SOURCE: FEX Primary/Primary_9C.asm
; FEX_SHA256: 52c5607e025eac57b9a7eb3e5c7fe87f1a9d642170f34a3b600660defa36b8b2
mov rsp, 0xe0000010

; Setup to default state
mov rax, 0
push rax
popfq

; These pushes will end up being the default rflags initialization value
pushfq

; nasm doesn't encode 16bit pushf
; put the prefix before the instruction manually
db 0x66
pushfq

mov rax, 0x0
mov rbx, 0x0

mov ax, word [rsp]
mov rbx, qword [rsp + 2]

hlt