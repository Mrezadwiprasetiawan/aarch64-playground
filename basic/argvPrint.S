.global main
.text
main:
  sub   sp, sp, 48          // Alokasikan ruang stack 48 byte
  stp   fp, lr, [sp, 32]  // Simpan frame pointer (fp=x29) dan return address (lr=x30)
  add   fp, sp, 32         // Atur frame pointer (fp=x29) ke sp+32
  stur  wzr, [fp, -4]      // Inisialisasi argc di sp-4 (padding karena argc int)
  stur  w0, [fp, -8]       // Simpan argc di sp-8
  stur   x1, [sp, 16]       // Simpan argv di sp+16
  stur   wzr, [sp, 12]      // Inisialisasi iterator (0) di sp+12
  b     .LoopLabel1         // Mulai loop

.LoopLabel1:
  ldr   w8, [sp, 12]        // Ambil iterator
  ldur  w9, [fp, -8]       // Ambil argc
  subs  w8, w8, w9          // Periksa apakah iterator >= argc
  b.ge  .LoopLabel3         // Jika ya, keluar dari loop

.LoopLabel2:
  ldr   x8, [sp, 16]        // Ambil argv (pointer ke array argumen)
  ldrsw x9, [sp, 12]        // Ambil iterator
  ldr   x1, [x8, x9, lsl #3] // Ambil argv[iterator]
  adrp  x0, .str            // Siapkan format string untuk printf
  add   x0, x0, :lo12:.str  // Tambahkan offset ke alamat string
  bl    printf              // Cetak argumen dengan printf

  ldr   w8, [sp, #12]       // Ambil iterator
  add   w8, w8, #1          // Increment iterator
  str   w8, [sp, #12]       // Simpan kembali iterator
  b     .LoopLabel1         // Ulangi loop

.LoopLabel3:
  mov   w0, wzr             // Set w0 ke 0 untuk keluar
  ldp   fp, lr, [sp, #32] // Pulihkan frame pointer dan return address
  add   sp, sp, #48         // Kembalikan sp ke posisi sebelumnya
  mov   x0, 0               // return value dari main
  ret                       // Kembali ke sistem operasi atau pengembalian fungsi

.end:
  .size main, .end-main     // Ukuran fungsi main
  .section .rodata
.str:
  .asciz "%s\n"             // Format string untuk printf
