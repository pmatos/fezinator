; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F7_07_2.asm
; FEX_SHA256: ee60f52fefb5efaf24b042633bdc8a99e5ebd910d9bb976979b463da313ac38f
mov r15, 0xe0000000

mov eax, 0x4
mov [r15 + 8 * 0], eax

mov rax, 0xFFFFFFFF00000000
mov rdx, 0xFFFFFFFF00000001

idiv dword [r15 + 8 * 0]

hlt