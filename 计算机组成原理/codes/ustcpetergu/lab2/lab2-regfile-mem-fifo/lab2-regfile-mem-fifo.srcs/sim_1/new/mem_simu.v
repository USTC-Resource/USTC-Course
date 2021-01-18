`timescale 1ns / 1ps
// RAM simu
// 2020 COD Lab2
// ustcpetergu

module mem_simu();
    reg clk;
    reg en, we;
    reg [3:0]addr;
    reg [7:0]din;
    wire [7:0]dout;

    ram_16x8 ram_16x8_inst
    (
        .clk(clk),
        .en(en),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        en = 1;
        we = 0;
        addr = 4'b1;
        din = 8'b0;

        #10
        we = 1;
        din = 8'b01111111;
        #10
        we = 0;
        #10
        addr = 4'b10;

        #20
        $finish;
    end
endmodule
