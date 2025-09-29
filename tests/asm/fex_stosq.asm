; BITS: 64
; SOURCE: FEX STOSQ.asm
; FEX_SHA256: d7febc506f34cd351d8133c59507fc69af0519f797fcbce6ad69c8d1b2b50175
; Starting address to store to
mov rdi, 0xe8000000

; How many elements we want to store
; Additional just in case STOS continues past for some reason
mov rcx, 0x100

; Data we want to store
mov rax, 0xDEADBEEFBAD0DAD1

; Direction to increment (Increment when cleared)
cld

; First fill the area with garbage without using STOS
mov rdx, 0
loop_header:
  mov [rdi + rdx * 8], rax
  add rdx, 1
  cmp rdx, rcx
  jne loop_header

; Now use STOS to fill the data with zero

mov rax, 0x0
mov rcx, 0x20
rep stosq

; Now read the data back and ensure it is zero

mov r14, 0xe8000000
mov r13, 0x20
mov r12, 0
mov r11, 0
loop_header2:
  add r11, [r14 + r12 * 8]
  add r12, 1
  cmp r12, r13
  jne loop_header2

hlt