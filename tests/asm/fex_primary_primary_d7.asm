; BITS: 64
; SOURCE: FEX Primary/Primary_D7.asm
; FEX_SHA256: a81fe985c69ceec067e83a234f0a4501f2038429c709a509ecf18d0d3523e0b8
; Save FS/GS
rdfsbase rax
mov [rel .data_backup], rax
rdgsbase rax
mov [rel .data_backup + 8], rax

mov rbx, 0xe0000000
lea r9, [rbx + 8 * 1]
wrfsbase r9
lea r9, [rbx + 8 * 2]
wrgsbase r9

mov rcx, 0x4142434445464748
mov [rbx + 8 * 0], rcx
mov rcx, 0x5152535455565758
mov [rbx + 8 * 1], rcx
mov rcx, 0x6162636465666768
mov [rbx + 8 * 2], rcx

; Base
mov rax, 0xFFFFFFFFFFFFFF01
xlatb
mov r15, rax

; FS
mov rax, 0xFFFFFFFFFFFFFF01
mov rbx, 0
fs xlat
mov r14, rax

; GS
mov rax, 0xFFFFFFFFFFFFFF01
mov rbx, 0
gs xlat
mov r13, rax

; Restore FS/GS
mov rax, [rel .data_backup]
wrfsbase rax
mov rax, [rel .data_backup + 8]
wrgsbase rax

hlt

.data_backup:
dq 0
dq 0