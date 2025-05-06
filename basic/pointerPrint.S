.global main
.rodata
.format: .asciz "%p\n"

main:
sub sp, sp, 16
stp fp, lr, [sp]

adrp x0, .format
add x0, x0, :lo12:.format

mov x1, x0
bl printf

ldp fp, lr, [sp]
add sp, sp, 16

mov x0, 0
ret
