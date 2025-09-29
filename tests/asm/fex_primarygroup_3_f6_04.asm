; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F6_04.asm
; FEX_SHA256: 278ac21a8dee9393047fc4ea4eba5d4a73085750f3ed8f4c8705c3cfeb06de6b
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax

mov al, 2
mul byte [rdx + 8 * 0 + 1]
mov word [rdx + 8 * 0], ax

; Ensure this inserts in to AX
mov rax, 0xFFFFFFFFFFFFFF02
mov rbx, 0xFFFFFFFFFFFFFF02
mul bl
mov rbx, rax

mov rax, [rdx + 8 * 0]

hlt