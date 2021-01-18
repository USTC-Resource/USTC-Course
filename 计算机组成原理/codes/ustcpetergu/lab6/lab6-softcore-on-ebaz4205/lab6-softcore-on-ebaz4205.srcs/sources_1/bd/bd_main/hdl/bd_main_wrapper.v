//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
//Date        : Fri Jul 10 16:25:12 2020
//Host        : petergu-dell running 64-bit Arch Linux
//Command     : generate_target bd_main_wrapper.bd
//Design      : bd_main_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module bd_main_wrapper
   (btndata,
    leddata,
    sysclk,
    uart_rx,
    uart_tx);
  input [1:0]btndata;
  output [1:0]leddata;
  input sysclk;
  input uart_rx;
  output uart_tx;

  wire [1:0]btndata;
  wire [1:0]leddata;
  wire sysclk;
  wire uart_rx;
  wire uart_tx;

  bd_main bd_main_i
       (.btndata(btndata),
        .leddata(leddata),
        .sysclk(sysclk),
        .uart_rx(uart_rx),
        .uart_tx(uart_tx));
endmodule
