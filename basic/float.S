.global main
.rodata
.comment.float: .asciz "%s%f\n"
.comment0: .asciz "Print literal float 1.7 : "
.comment1: .asciz "Print float 1.7 + 2.1 : "
.text
main:
//sub sp untuk alokasi stack untuk menyimpan fp dan lr
sub sp, sp, 16

/*simpan fp dan lr karena instruksi bl akan overwrite lr yang bisa loop
 *tak berujung karena main perlh kembali ke assembly bawaan c++
*/
stp fp,lr, [sp]

/*karena hanya bisa encoded 8 bit saja, maka pisahkan menjadi
 *1.5 + 1.0/5.0
*/
fmov d0, 1.5
fmov d1, 1.0
fmov d2, 5.0
fdiv d1, d1, d2
fadd d0, d0, d1 

// alokasi untuk menyimpan 1.7 dan 0.2 karena printf otomatis menset semua register ke 0(non pointer fp sp dan lr)
sub sp, sp ,32
stp d0, d1, [sp]

/* load address adrp untuk 52 bit alamat dan tambahkan dengan 12 bit lownya
 * ini karena keterbatasan instruksi aarch6r untuk alamat 64 bit
 * dan tidak ada jaminan bahwa alamat cukup dekat jika PIC/PIE
*/
// load string format
adrp x0, .comment.float
add x0, x0, :lo12:.comment.float
// load strinf comment
adrp x1, .comment0
add x1, x1, :lo12:.comment0

bl printf

// restore d0
ldp d0,d1,[sp]

//menggunakan 2.1 sebagai 2.0 + 0.1 dari 0.2/2
fmov d2, 2.0
fdiv d1, d1, d2
fadd d1, d1,d2
fadd d0, d0, d1

adrp x0, .comment.float
add x0, x0, :lo12:.comment.float

//load string comment kedua
adrp x1, .comment1
add x1, x1, :lo12:.comment1

bl printf


//kembalikan fp dan lr 16 karena 32 bitnya sudah dipakai d0 dan d1
ldp fp, lr, [sp, 32]
//kembalikan sp 16 untuk fp dan lr dan 16 untuk d0
add sp, sp, 48
ret
