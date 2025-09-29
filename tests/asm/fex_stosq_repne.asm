; BITS: 64
; SOURCE: FEX STOSQ_REPNE.asm
; FEX_SHA256: 96873664fd7f6a4c686729b731149fce7311366f1a127aaa4e24397fb4c2ac79
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
repne stosq

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