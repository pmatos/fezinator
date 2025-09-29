; BITS: 64
; SOURCE: FEX mov.asm
; FEX_SHA256: d8c81f87e0829f946799db9285a7218d48d806e130bd77b3ade50b134ee77378
; LIVEIN:
; LIVEOUT: r15, rax, rbx, rcx, rdx
; EXITS: 0x0040101f: Fall through
; MEMORY:
mov rax, -1
mov rbx, -1
mov rcx, -1

mov r15, qword 0xDEADBEEFBAD0DAD1
mov rdx, qword 0xDEADBEEFBAD0DAD1

;mov al, dl
;mov bx, dx
;mov ecx, edx
;mov al, -1
;mov ax, -1
;mov eax, -1
;mov rax, qword -1
;mov rax, 0
;mov al, al
;mov rbx, -1
;mov bx, ax
;mov ax, ax
;mov ax, ax
;mov eax, eax
;mov rax, rax
hlt