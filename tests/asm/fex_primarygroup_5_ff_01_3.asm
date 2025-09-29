; BITS: 64
; SOURCE: FEX PrimaryGroup/5_FF_01_3.asm
; FEX_SHA256: 6bfc65da3089ff1e3fc1e1122c9ab21ea239efe547dd6344fa8b7ea708b8a8d9
mov r15, 0xe0000000

mov rax, 0x0000000000000000
mov [r15 + 8 * 0], rax
mov [r15 + 8 * 1], rax
mov [r15 + 8 * 2], rax
mov [r15 + 8 * 3], rax

xor rax, rax

; Insure that dec underflow works and sets correct flags
dec  byte [r15 + 8 * 0 + 0]
lahf
mov r8, rax

dec  word [r15 + 8 * 1 + 0]
lahf
mov r9, rax

dec dword [r15 + 8 * 2 + 0]
lahf
mov r10, rax

dec qword [r15 + 8 * 3 + 0]
lahf
mov r11, rax


mov rax, [r15 + 8 * 0]
mov rbx, [r15 + 8 * 1]
mov rcx, [r15 + 8 * 2]
mov rdx, [r15 + 8 * 3]


; Mask flags we don't care about
and r8, 0xd400
and r9, 0xd400
and r10, 0xd400
and r11, 0xd400

hlt