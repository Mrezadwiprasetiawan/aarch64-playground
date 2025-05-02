.global main
.text
main:
  sub   sp, sp, 48
  stp   x29, x30, [sp, 32]     // simpan 16 byte register address saat ini
  add   x29, sp, 32
  stur  wzr, [x29, #-4]
  stur  w0, [x29, #-8]
  str   x1, [sp, #16]
  str     wzr, [sp, #12]
  b       .LoopLabel1

.LoopLabel1:
  ldr   w8, [sp, #12]
  ldur  w9, [x29, #-8]
  subs  w8, w8, w9
  b.ge  .LoopLabel4
  b     .LoopLabel2

.LoopLabel2:
  ldr   x8, [sp, #16]
  ldrsw x9, [sp, #12]
  ldr   x1, [x8, x9, lsl #3]
  adrp  x0, .L.str
  add   x0, x0, :lo12:.L.str
  bl    printf
  b     .LoopLabel3

.LoopLabel3:   
  ldr   w8, [sp, #12]
  add   w8, w8, #1
  str   w8, [sp, #12]
  b     .LoopLabel1

.LoopLabel4:
  mov   w0, wzr
  ldp   x29, x30, [sp, #32]
  add   sp, sp, #48
  ret

.Lfunc_end:
  .size main, .Lfunc_end-main
  .section .rodata.str1.1,"aMS",@progbits,1
.L.str:
  .asciz "%s\n"
