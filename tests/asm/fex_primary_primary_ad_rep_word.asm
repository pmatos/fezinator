; BITS: 64
; SOURCE: FEX Primary/Primary_AD_REP_word.asm
; FEX_SHA256: 9143227f460a0a104f39fd05a6129f6ef75673f63af34d485bf99e7e77fdeb19
mov rdx, 0xe0000000

mov rax, 0x4142434445464748
mov [rdx + 8 * 0], rax
mov rax, 0x5152535455565758
mov [rdx + 8 * 1], rax
mov rax, 0x0
mov [rdx + 8 * 2], rax
mov [rdx + 8 * 3], rax

lea rsi, [rdx + 8 * 0]

cld
mov rax, 0xFF
mov rcx, 8
rep lodsw

hlt