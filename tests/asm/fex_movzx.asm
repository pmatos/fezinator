; BITS: 64
; SOURCE: FEX movzx.asm
; FEX_SHA256: 3a29ac93938ea9326c7566b060595e83b78d143ee17888f1a359ff7366f069a2
mov rax, qword 0xDEADBEEFBAD0DAD1

mov rbx, -1
mov rcx, -1
mov rdx, -1
mov rdi, -1

movzx bx,  al ; 8bit-> 16bit
movzx ecx, al ; 8bit-> 32bit
movzx edx, ax ; 16bit-> 32bit
movzx rdi, ax ; 16bit -> 64bit

hlt