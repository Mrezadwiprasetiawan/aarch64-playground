.global main
.text
main:
  sub   sp, sp, 48
  stp   x29, x30, [sp, 32]  // simpan 16 byte register address
                            // x29(fp) ke sp+32 x30(link ret) ke sp+40
  add   x29, sp, 32         // ubah fp ke sp+32
  stur  wzr, [x29, -4]      // isi fp-4 dengan 0 (padding untuk argc)
  stur  w0, [x29, -8]       // isi fp-8 dengan argc
  stur   x1, [sp, 16]       // isi sp+16 dengan argv
  stur   wzr, [sp, 12]      // isi sp+12 dengan 0 (padding untuk argv)
  b     .LoopLabel1

.LoopLabel1:
  ldr   w8, [sp, 12]
  ldur  w9, [x29, -8]
  subs  w8, w8, w9
  b.ge  .LoopLabel3

.LoopLabel2:
  ldr   x8, [sp, 16]
  ldrsw x9, [sp, 12]
  ldr   x1, [x8, x9, lsl #3]
  adrp  x0, .L.str
  add   x0, x0, :lo12:.L.str
  bl    printf
 
  ldr   w8, [sp, #12]
  add   w8, w8, #1
  str   w8, [sp, #12]
  b     .LoopLabel1

.LoopLabel3:
  mov   w0, wzr
  ldp   x29, x30, [sp, #32]
  add   sp, sp, #48
  ret

.Lend:
  .size main, .Lend-main
  .section .rodata.str.1,"aMS",@progbits,1
.L.str:
  .asciz "%s\n"
