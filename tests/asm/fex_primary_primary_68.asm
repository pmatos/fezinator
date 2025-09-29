; BITS: 64
; SOURCE: FEX Primary/Primary_68.asm
; FEX_SHA256: 8c00088f7bac3c05a890bd00487861745def17743a240bf41f523dd4f74328d8
mov rsp, 0xe0000020

push qword -0x41424345
push word 0x5152
push word 0x6162

mov rdx, 0xe0000020
mov rax, [rdx - 8]
mov ebx, [rdx - 12]

hlt