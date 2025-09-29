; BITS: 64
; SOURCE: FEX PrimaryGroup/5_FF_05_03_o32.asm
; FEX_SHA256: c93e9dceadc029998cb7901a690613bce865070dd07ca54f5b74eb7daa7991df
mov rsp, 0xe000_1000
mov ax, cs
lea edi, [rel .success]

sub rsp, 16
mov [rsp], edi
mov [rsp+4], cs

mov rax, 0
call far dword [esp]

hlt

.success:
mov rax, 1
mov rbx, rsp
o32 retf