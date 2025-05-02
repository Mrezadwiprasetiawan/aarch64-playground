.section .data
msg :.asciz "Hello World!\n" //label address
len = . - msg // symbolic value
.section .text
.global main
main:
 adr x1, msg
 mov x0,1  // 1 fd stdout
 mov x2, len
 mov x8,64 // sys_write
 svc 0
 mov x0, 0
 ret
