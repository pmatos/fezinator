; BITS: 64
; SOURCE: FEX PrimaryGroup/5_FF_05_03_o32_imm.asm
; FEX_SHA256: dd8e6d0437d1dcd51e7f5c1cb2265b86644a4eb151a4cb4148dc6b3645141548
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
o32 retf 0x1234