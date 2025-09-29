; BITS: 64
; SOURCE: FEX PrimaryGroup/3_F7_05_2.asm
; FEX_SHA256: 23bd0b980b55a940ad6dd9800ee75cea8b65a32ff7bc7bad1461b1ab7335ecde
; Uses CX and BX and stores result in r15
; OF:CF
%macro ofcfmerge 0
  lahf

  ; Load OF
  mov rbx, 0
  seto bl

  shl r15, 1
  or r15, rbx
  shl r15, 1

  ; Insert CF
  shr ax, 8
  and rax, 1
  or r15, rax
%endmacro

mov r8, 0xe0000000
mov r15, 0

mov rax, -1
mov [r8 + 8 * 0], rax
mov rax, -2
mov [r8 + 8 * 1], rax
mov rax, -3
mov [r8 + 8 * 2], rax

mov rax, 1
mov [r8 + 8 * 3], rax
mov rax, 2
mov [r8 + 8 * 4], rax
mov rax, 3
mov [r8 + 8 * 5], rax

; Negative * Negative
mov ax, -128
cwd
imul word [r8 + 8 * 0 + 0]
ofcfmerge

mov eax, -128
cdq
imul dword [r8 + 8 * 1 + 0]
ofcfmerge

mov rax, -128
cqo
imul qword [r8 + 8 * 2 + 0]
ofcfmerge

; Negative * Positive
mov ax, -128
cwd
imul word [r8 + 8 * 3 + 0]
ofcfmerge

mov eax, -128
cdq
imul dword [r8 + 8 * 4 + 0]
ofcfmerge

mov rax, -128
cqo
imul qword [r8 + 8 * 5 + 0]
ofcfmerge

; Positive * Positive
mov ax, 128
cwd
imul word [r8 + 8 * 3 + 0]
ofcfmerge

mov eax, 128
cdq
imul dword [r8 + 8 * 4 + 0]
ofcfmerge

mov rax, 128
cqo
imul qword [r8 + 8 * 5 + 0]
ofcfmerge

hlt