; BITS: 64
; SOURCE: FEX TwoByte/0F_48.asm
; FEX_SHA256: a2cd3126514101038cb26a0ce81c5b9390adc167504eafbb3f85b6126adf94a8
mov r15, 0xe0000000

mov rax, 0x0
mov [r15 + 8 * 0], rax
mov rax, 0x1
mov [r15 + 8 * 1], rax
mov rax, 0x2
mov [r15 + 8 * 2], rax

mov r10, 0x1
mov r11, 0x0
mov r12, 0x2

cmp r10d, r12d

mov rax, -1
mov rbx, -1
cmovs  rax, [r15 + 8 * 1]
cmovns rbx, [r15 + 8 * 0]

hlt