; BITS: 64
; SOURCE: FEX Primary/Primary_A6_REPNE_Equal.asm
; FEX_SHA256: 3828592ebccf8bf74aacaa37de6f26430c8e0179b3b665f432df2b1d8d22705d
%macro copy 3
  ; Dest, Src, Size
  mov rdi, %1
  mov rsi, %2
  mov rcx, %3

  cld
  repne movsb
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
repe cmpsb ; rdi cmp rsi
mov rax, 0
lahf

mov rdx, 0
sete dl

hlt

.StringOne: db "TestString\0"
.StringTwo: db "TestString\0"