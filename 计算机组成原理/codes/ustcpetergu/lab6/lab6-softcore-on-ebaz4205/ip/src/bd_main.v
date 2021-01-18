//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
//Date        : Fri Jul 10 16:25:12 2020
//Host        : petergu-dell running 64-bit Arch Linux
//Command     : generate_target bd_main.bd
//Design      : bd_main
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "bd_main,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=bd_main,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=8,numReposBlks=8,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=5,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "bd_main.hwdef" *) 
module bd_main
   (btndata,
    leddata,
    sysclk,
    uart_rx,
    uart_tx);
  input [1:0]btndata;
  output [1:0]leddata;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.SYSCLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.SYSCLK, CLK_DOMAIN bd_main_sysclk, FREQ_HZ 125000000, INSERT_VIP 0, PHASE 0.000" *) input sysclk;
  input uart_rx;
  output uart_tx;

  wire [31:0]bootrom_spo;
  wire [1:0]btndata_1;
  wire [31:0]cpu_multi_cycle_0_a;
  wire [31:0]cpu_multi_cycle_0_d;
  wire cpu_multi_cycle_0_we;
  wire [1:0]debounce_0_o_state;
  wire [1:0]gpio_0_led;
  wire [31:0]gpio_0_spo;
  wire [31:0]main_memory_spo;
  wire [8:0]mmapper_0_bootm_a;
  wire [1:0]mmapper_0_gpio_a;
  wire [31:0]mmapper_0_gpio_d;
  wire mmapper_0_gpio_we;
  wire [8:0]mmapper_0_mainm_a;
  wire [31:0]mmapper_0_mainm_d;
  wire mmapper_0_mainm_we;
  wire [31:0]mmapper_0_spo;
  wire [2:0]mmapper_0_uart_a;
  wire [31:0]mmapper_0_uart_d;
  wire mmapper_0_uart_we;
  wire rx_0_1;
  wire sysclk_1;
  wire [31:0]uart_0_spo;
  wire uart_0_tx;
  wire [0:0]xlslice_0_Dout;

  assign btndata_1 = btndata[1:0];
  assign leddata[1:0] = gpio_0_led;
  assign rx_0_1 = uart_rx;
  assign sysclk_1 = sysclk;
  assign uart_tx = uart_0_tx;
  bd_main_dist_mem_gen_0_0 bootrom
       (.a(mmapper_0_bootm_a),
        .spo(bootrom_spo));
  bd_main_cpu_multi_cycle_0_0 cpu_multi_cycle_0
       (.a(cpu_multi_cycle_0_a),
        .clk(sysclk_1),
        .d(cpu_multi_cycle_0_d),
        .rst(xlslice_0_Dout),
        .spo(mmapper_0_spo),
        .we(cpu_multi_cycle_0_we));
  bd_main_debounce_0_0 debounce_0
       (.clk(sysclk_1),
        .i_btn(btndata_1),
        .o_state(debounce_0_o_state));
  bd_main_gpio_0_0 gpio_0
       (.a(mmapper_0_gpio_a),
        .btn(debounce_0_o_state),
        .clk(sysclk_1),
        .d(mmapper_0_gpio_d),
        .led(gpio_0_led),
        .rst(xlslice_0_Dout),
        .spo(gpio_0_spo),
        .we(mmapper_0_gpio_we));
  bd_main_dist_mem_gen_0_1 main_memory
       (.a(mmapper_0_mainm_a),
        .clk(sysclk_1),
        .d(mmapper_0_mainm_d),
        .spo(main_memory_spo),
        .we(mmapper_0_mainm_we));
  bd_main_mmapper_0_0 mmapper_0
       (.a(cpu_multi_cycle_0_a),
        .bootm_a(mmapper_0_bootm_a),
        .bootm_spo(bootrom_spo),
        .d(cpu_multi_cycle_0_d),
        .gpio_a(mmapper_0_gpio_a),
        .gpio_d(mmapper_0_gpio_d),
        .gpio_spo(gpio_0_spo),
        .gpio_we(mmapper_0_gpio_we),
        .mainm_a(mmapper_0_mainm_a),
        .mainm_d(mmapper_0_mainm_d),
        .mainm_spo(main_memory_spo),
        .mainm_we(mmapper_0_mainm_we),
        .spo(mmapper_0_spo),
        .uart_a(mmapper_0_uart_a),
        .uart_d(mmapper_0_uart_d),
        .uart_spo(uart_0_spo),
        .uart_we(mmapper_0_uart_we),
        .we(cpu_multi_cycle_0_we));
  bd_main_uart_0_0 uart_0
       (.a(mmapper_0_uart_a),
        .clk(sysclk_1),
        .d(mmapper_0_uart_d),
        .rst(xlslice_0_Dout),
        .rx(rx_0_1),
        .spo(uart_0_spo),
        .tx(uart_0_tx),
        .we(mmapper_0_uart_we));
  bd_main_xlslice_0_0 xlslice_0
       (.Din(debounce_0_o_state),
        .Dout(xlslice_0_Dout));
endmodule
