; BITS: 64
; SOURCE: FEX PrimaryGroup/5_FF_00_3.asm
; FEX_SHA256: a5460691a576e19c6b818e35a17197ff731703abed3980c4737ae1db2c170aa8
mov r15, 0xe0000000

mov rax, 0xffffffffffffffff
mov [r15 + 8 * 0], rax
mov [r15 + 8 * 1], rax
mov [r15 + 8 * 2], rax
mov [r15 + 8 * 3], rax

xor rax, rax

; Insure that inc overflow works and sets correct flags
inc  byte [r15 + 8 * 0 + 0]
lahf
mov r8, rax

inc  word [r15 + 8 * 1 + 0]
lahf
mov r9, rax

inc dword [r15 + 8 * 2 + 0]
lahf
mov r10, rax

inc qword [r15 + 8 * 3 + 0]
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