.globl _main
.align 2

.equ SYS_READ,  3
.equ SYS_WRITE, 4
.equ SYS_EXIT,  1
.equ BUF_SIZE,  256
.equ MAX_N,     100

_main:
    sub sp, sp, #BUF_SIZE + MAX_N*8
    mov x19, sp                     // буфер для строки
    add x20, sp, #BUF_SIZE          // массив результатов (по 8 байт)

    // ----- чтение числа n -----
    mov x21, #0                     // n = 0
    mov x22, #0                     // индекс в буфере
read_n:
    mov x0, #0
    add x1, x19, x22
    mov x2, #1
    mov x16, #SYS_READ
    svc #0x80
    cmp x0, #1
    b.ne error
    ldrb w0, [x19, x22]
    cmp w0, #'\n'
    b.eq n_done
    cmp w0, #'0'
    b.lo read_n
    cmp w0, #'9'
    b.hi read_n
    sub w0, w0, #'0'
    mov x23, x21
    lsl x21, x23, #1
    add x21, x21, x23, lsl #3
    add x21, x21, x0
    add x22, x22, #1
    b read_n
n_done:
    cmp x21, #0
    b.eq success
    cmp x21, #MAX_N
    b.gt error

    mov x22, #0                     // счётчик строк

    // ----- чтение и обработка строк -----
read_all:
    cmp x22, x21
    b.eq print_all

    mov x23, #0                     // длина строки
read_line:
    mov x0, #0
    add x1, x19, x23
    mov x2, #1
    mov x16, #SYS_READ
    svc #0x80
    cmp x0, #1
    b.ne error
    ldrb w0, [x19, x23]
    cmp w0, #'\n'
    b.eq line_done
    add x23, x23, #1
    cmp x23, #BUF_SIZE-1
    b.lt read_line
line_done:
    // проверка цифр и подсчёт чётных
    mov x24, #0                     // счётчик чётных
    mov x25, #0                     // индекс
check:
    cmp x25, x23
    b.ge check_end
    ldrb w0, [x19, x25]
    sub w0, w0, #'0'
    cmp w0, #9
    b.hi error
    and w1, w0, #1
    cbz w1, inc_even
    b next
inc_even:
    add x24, x24, #1
next:
    add x25, x25, #1
    b check
check_end:
    cmp x23, #1
    b.eq store_dash
    str x24, [x20, x22, lsl #3]
    b store_next
store_dash:
    mov x26, #-1                    // -1 означает дефис
    str x26, [x20, x22, lsl #3]
store_next:
    add x22, x22, #1
    b read_all

    // ----- вывод результатов -----
print_all:
    mov x22, #0
print_loop:
    cmp x22, x21
    b.eq success
    ldr x26, [x20, x22, lsl #3]
    cmp x26, #-1
    b.eq print_dash
    mov x0, x26
    bl  print_number
    b print_space
print_dash:
    mov x0, #1
    adr x1, dash_str
    mov x2, #1
    mov x16, #SYS_WRITE
    svc #0x80
print_space:
    mov x0, #1
    adr x1, space_str
    mov x2, #1
    mov x16, #SYS_WRITE
    svc #0x80
    add x22, x22, #1
    b print_loop

success:
    add sp, sp, #BUF_SIZE + MAX_N*8
    mov x0, #0
    b exit

error:
    adr x1, error_msg
    mov x2, error_len
    mov x16, #SYS_WRITE
    svc #0x80
    mov x0, #1
exit:
    mov x16, #SYS_EXIT
    svc #0x80

// ----- вывод числа (x0) в stdout -----
print_number:
    sub sp, sp, #32
    str x30, [sp]
    add x1, sp, #24
    mov x2, #0
    mov x3, #10
    mov x4, x0
    cbnz x4, 1f
    mov w5, #'0'
    sub x1, x1, #1
    strb w5, [x1]
    mov x2, #1
    b print_done
1:
2:
    udiv x5, x4, x3
    msub x6, x5, x3, x4
    add x6, x6, #'0'
    sub x1, x1, #1
    strb w6, [x1]
    add x2, x2, #1
    mov x4, x5
    cbnz x4, 2b
print_done:
    mov x0, #1
    mov x16, #SYS_WRITE
    svc #0x80
    ldr x30, [sp]
    add sp, sp, #32
    ret

dash_str:
    .ascii "-"
space_str:
    .ascii " "
error_msg:
    .ascii "Error: non-digit character\n"
error_len = . - error_msg