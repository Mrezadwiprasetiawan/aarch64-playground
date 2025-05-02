.section .data
msg :.asciz "Hello World!\n" //label address
len = . - msg // symbolic value
.section .text
.global _start
_start:
 adrp x1, msg //52 bit atas
 add x1, x1, :lo12:msg //12 bit low
 mov x0,1  // 1 fd stdout
 mov x2, len
 mov x8,64 // sys_write
 svc 0
 mov x0, 1
 mov x8, 93
 svc 0
