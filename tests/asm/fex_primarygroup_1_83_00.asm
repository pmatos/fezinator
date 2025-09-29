; BITS: 64
; SOURCE: FEX PrimaryGroup/1_83_00.asm
; FEX_SHA256: eeb72645778fdf03cfbc546bb0abdcb041399b6006af92d7cf941c4aecaed98d
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x6162636465666768
mov [rdx + 8 * 2], rax

add  word [rdx + 8 * 0 + 0], -31
add dword [rdx + 8 * 1 + 0], -31
add qword [rdx + 8 * 2 + 0], -31

mov rax, [rdx + 8 * 0]
mov rbx, [rdx + 8 * 1]
mov rcx, [rdx + 8 * 2]

hlt