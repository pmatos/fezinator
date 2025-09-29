; BITS: 64
; SOURCE: FEX Primary/Primary_C8_2.asm
; FEX_SHA256: 69794ce9f02dd6330a190790c747f2cd35b50303646ca03b1885c0ca8b02cab8
mov rsp, 0xe0001000
mov rbp, 0xe0002000
mov rax, 0x4142434445464748
mov qword [rbp - 8], rax

enter 0x10, 2
mov rax, qword [rsp + 0x18]

hlt