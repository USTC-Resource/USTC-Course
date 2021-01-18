// (c) Copyright 1995-2020 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:mmapper:1.0
// IP Revision: 1

(* X_CORE_INFO = "mmapper,Vivado 2019.1" *)
(* CHECK_LICENSE_TYPE = "bd_main_mmapper_0_0,mmapper,{}" *)
(* CORE_GENERATION_INFO = "bd_main_mmapper_0_0,mmapper,{x_ipProduct=Vivado 2019.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=mmapper,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module bd_main_mmapper_0_0 (
  a,
  d,
  we,
  spo,
  bootm_a,
  bootm_d,
  bootm_we,
  bootm_spo,
  mainm_a,
  mainm_d,
  mainm_we,
  mainm_spo,
  gpio_a,
  gpio_d,
  gpio_we,
  gpio_spo,
  uart_a,
  uart_d,
  uart_we,
  uart_spo
);

input wire [31 : 0] a;
input wire [31 : 0] d;
input wire we;
output wire [31 : 0] spo;
output wire [8 : 0] bootm_a;
output wire [31 : 0] bootm_d;
output wire bootm_we;
input wire [31 : 0] bootm_spo;
output wire [8 : 0] mainm_a;
output wire [31 : 0] mainm_d;
output wire mainm_we;
input wire [31 : 0] mainm_spo;
output wire [1 : 0] gpio_a;
output wire [31 : 0] gpio_d;
output wire gpio_we;
input wire [31 : 0] gpio_spo;
output wire [2 : 0] uart_a;
output wire [31 : 0] uart_d;
output wire uart_we;
input wire [31 : 0] uart_spo;

  mmapper inst (
    .a(a),
    .d(d),
    .we(we),
    .spo(spo),
    .bootm_a(bootm_a),
    .bootm_d(bootm_d),
    .bootm_we(bootm_we),
    .bootm_spo(bootm_spo),
    .mainm_a(mainm_a),
    .mainm_d(mainm_d),
    .mainm_we(mainm_we),
    .mainm_spo(mainm_spo),
    .gpio_a(gpio_a),
    .gpio_d(gpio_d),
    .gpio_we(gpio_we),
    .gpio_spo(gpio_spo),
    .uart_a(uart_a),
    .uart_d(uart_d),
    .uart_we(uart_we),
    .uart_spo(uart_spo)
  );
endmodule
