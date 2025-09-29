; BITS: 64
; SOURCE: FEX PrimaryGroup/5_FF_01_2.asm
; FEX_SHA256: c70b032b8b0feecdfcfd55e9d06927aecea05f34b6be760498369c224a21bf38
mov r15, 0xe0000000

mov rax, 0x4142434445464748
mov [r15 + 8 * 0], rax
mov [r15 + 8 * 1], rax
mov [r15 + 8 * 2], rax
mov [r15 + 8 * 3], rax
mov [r15 + 8 * 4], rax
mov [r15 + 8 * 5], rax
mov [r15 + 8 * 6], rax

; Ensures that all the flag setting matches correctly
dec  word [r15 + 8 * 0 + 0]
mov rax, 0
mov r14, 0
lahf
mov r14, rax

lock dec  word [r15 + 8 * 1 + 0]
mov rax, 0
lahf
xor r14, rax

dec dword [r15 + 8 * 2 + 0]
mov rax, 0
mov r13, 0
lahf
mov r13, rax

lock dec dword [r15 + 8 * 3 + 0]
mov rax, 0
lahf
xor r13, rax

dec qword [r15 + 8 * 4 + 0]
mov rax, 0
mov r12, 0
lahf
mov r12, rax

lock dec qword [r15 + 8 * 5 + 0]
mov rax, 0
lahf
xor r12, rax

dec byte [r15 + 8 * 4 + 0]
mov rax, 0
mov r11, 0
lahf
mov r11, rax

lock dec byte [r15 + 8 * 5 + 0]
mov rax, 0
lahf
xor r11, rax


hlt