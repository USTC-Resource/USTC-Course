`timescale 1ns / 1ps

module mmapper
    (
        input [31:0]a,
        input [31:0]d,
        //input [31:0]dpra,
        input we,
        output reg [31:0]spo,
        //output reg [31:0]dpo = 0,

        // 1024*32(4KB) boot rom: 0x00000000
        output reg [8:0]bootm_a,
        output reg [31:0]bootm_d,
        output reg bootm_we,
        input [31:0]bootm_spo,

        // main memory: 0x10000000
        output reg [8:0]mainm_a,
        output reg [31:0]mainm_d,
        output reg mainm_we,
        input [31:0]mainm_spo,

        // gpio: 0x20000000
        output reg [1:0]gpio_a,
        output reg [31:0]gpio_d,
        output reg gpio_we,
        input [31:0]gpio_spo,

        // fifo uart: 
        // write 0x30000000
        // full 0x30000004
        // empty 0x30000008
        output reg [2:0]uart_a,
        output reg [31:0]uart_d,
        output reg uart_we,
        input [31:0]uart_spo
    );

    always @ (*) begin 
        bootm_a = a[10:2];
        bootm_d = d;
        mainm_a = a[10:2];
        mainm_d = d;
        gpio_a = a[3:2];
        gpio_d = d;
        uart_a = a[4:2];
        uart_d = d;
    end

    always @ (*) begin
        bootm_we = 0;
        mainm_we = 0;
        gpio_we = 0;
        uart_we = 0;
        case (a[31:28])
            0: begin spo = bootm_spo; bootm_we = we; end
            1: begin spo = mainm_spo; mainm_we = we; end
            2: begin spo = gpio_spo; gpio_we = we; end
            3: begin spo = uart_spo; uart_we = we; end
            default: ;
        endcase
    end
endmodule
