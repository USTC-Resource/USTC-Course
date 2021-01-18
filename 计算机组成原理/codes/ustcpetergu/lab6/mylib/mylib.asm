.text

.globl uart_putchar
.globl uart_getchar
.globl led_ctrl

# void uart_putchar(char c)
uart_putchar:
    lw $t2, uart_addr
_uart_putchar_wait1:
    lw $t0, 8($t2)
    beq $t0, $0, _uart_putchar_wait1
    sw $a0, 0($t2) # do the real work
_uart_putchar_wait2:
    lw $t0, 8($t2)
    beq $t0, $0, _uart_putchar_wait2
    jr $ra

# char uart_getchar()
uart_getchar:
    lw $t2, uart_addr
    addi $t1, $0, 1
    sw $t1, 4($t2)
_loop_uart_getchar:
    lw $t0, 4($t2)
    beq $t0, $0, _loop_uart_getchar
    lw $t0, 0($t2)
    addi $v0, $t0, 0
    jr $ra

# void gpio_addr(int a)
led_ctrl:
    lw $t2, gpio_addr
    addi $t1, $t2, 8
    sw $a0, 0($t1)
    addi $t1, $t2, 12
    sw $a0, 0($t1)
    jr $ra

.data
    uart_addr: .word 0x30000000
    gpio_addr: .word 0x20000000
