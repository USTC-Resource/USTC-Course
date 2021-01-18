.section .text.boot

_start:
    addi $a0, $zero, 0
    jal led_ctrl
    addi $a0, $zero, 'O'
    jal uart_putchar
    addi $a0, $zero, 'K'
    jal uart_putchar
    lw $s0, mem_addr
_input:
    addi $a0, $zero, '\r'
    jal uart_putchar
    addi $a0, $zero, '\n'
    jal uart_putchar
    addi $s1, $zero, 0 # loop variable
_loop_input:
    jal uart_getchar
    add $t0, $s0, $s1
    sw $v0, 0($t0)
    addi $t0, $zero, '\r'
    beq $v0, $t0, _print
    addi $a0, $zero, '.'
    jal uart_putchar
    addi $s1, $s1, 4
    j _loop_input
_print:
    addi $a0, $zero, '\r'
    jal uart_putchar
    addi $a0, $zero, '\n'
    jal uart_putchar
    addi $s1, $zero, 0
_loop_print:
    add $t0, $s0, $s1
    lw $a0, 0($t0)
    jal uart_putchar
    addi $t0, $zero, '\r'
    beq $a0, $t0, _input
    addi $s1, $s1, 4
    j _loop_print

.text 
    mem_addr: .word 0x10000000
