; BITS: 64
; SOURCE: FEX Primary/Primary_A6_REP_down_Equal.asm
; FEX_SHA256: e58225d860ee262f36657a3ef59867fcd3a98908c8399cfee28a1b93c6c1abcf
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

lea rdi, [rdx + 8 * 0 + 10]
lea rsi, [rdx + 8 * 2 + 10]

std
mov rcx, 11 ; Lower String length
repe cmpsb ; rdi cmp rsi
mov rax, 0
lahf

mov rdx, 0
sete dl

hlt

.StringOne: db "\0TestString"
.StringTwo: db "\0TestString"