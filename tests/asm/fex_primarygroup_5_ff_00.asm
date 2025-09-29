; BITS: 64
; SOURCE: FEX PrimaryGroup/5_FF_00.asm
; FEX_SHA256: 9c410f16503b6a85fe922d4565aab3af61ec86f55899f32db14044201bcf5b9f
mov r15, 0xe0000000

mov rax, 0x4142434445464748
mov [r15 + 8 * 0], rax
mov rax, 0x5152535455565758
mov [r15 + 8 * 1], rax
mov rax, 0x6162636465666768
mov [r15 + 8 * 2], rax

inc  word [r15 + 8 * 0 + 0]
inc dword [r15 + 8 * 1 + 0]
inc qword [r15 + 8 * 2 + 0]

mov rax, [r15 + 8 * 0]
mov rbx, [r15 + 8 * 1]
mov rcx, [r15 + 8 * 2]

hlt