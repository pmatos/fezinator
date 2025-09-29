; BITS: 64
; SOURCE: FEX Primary/Primary_A6_REPNE.asm
; FEX_SHA256: 3c70d4d31d81f783868500013a33bb00ff6df8d89ce14cc9488527582d461af4
%macro copy 3
  ; Dest, Src, Size
  mov rdi, %1
  mov rsi, %2
  mov rcx, %3

  cld
  rep movsb
%endmacro

mov rdx, 0xe0000000

lea r15, [rdx + 8 * 0]
lea r14, [rel .StringOne]
copy r15, r14, 11

lea r15, [rdx + 8 * 2]
lea r14, [rel .StringTwo]
copy r15, r14, 11

lea rdi, [rdx + 8 * 0]
lea rsi, [rdx + 8 * 2]

cld
mov rcx, 10 ; Lower String length
repne cmpsb ; rdi cmp rsi
mov rax, 0
lahf

mov rdx, 0
sete dl

hlt

.StringOne: db "StringTest\0"
.StringTwo: db "UnmatcTest\0"