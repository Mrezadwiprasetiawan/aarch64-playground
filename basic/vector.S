.rodata
.format: .asciz "%d %d %d %d\n"

.global main
.text
main:
sub sp, sp, 16
stp fp, lr, [sp]
mov fp, sp

mov w0, 1

ins v0.s[0], w0
ins v0.s[1], w0
ins v0.s[2], w0
ins v0.s[3], w0

// print v0
adrp x0, .format
add x0, x0, :lo12:.format
umov w1, v0.s[0]
umov w2, v0.s[1]
umov w3, v0.s[2]
umov w4, v0.s[3]
bl printf

ldp fp, lr, [sp]
add sp, sp, 16
mov x0, 0
ret
