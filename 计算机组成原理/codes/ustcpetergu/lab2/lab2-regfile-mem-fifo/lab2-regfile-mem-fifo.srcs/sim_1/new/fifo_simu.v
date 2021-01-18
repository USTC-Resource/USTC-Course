`timescale 1ns / 1ps
// fifo simu
// 2020 COD Lab2
// ustcpetergu

module fifo_simu();
    reg clk, rst;
    reg [7:0]din;
    reg en_in;
    reg en_out;
    wire en_in_in;
    wire en_out_in;
    wire [7:0]dout;
    wire [4:0]count;

    fifo fifo_inst
    (
        .clk(clk),
        .rst(rst),
        .din(din),
        .en_in(en_in),
        .en_out(en_out),
        .en_in_in(en_in_in),
        .en_out_in(en_out_in),
        .dout(dout),
        .count(count)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        en_in = 0;
        en_out = 0;
        din = 0;

        #10
        rst = 0;
        en_in = 1;
        din = 8'hf0;

	#40
        #10
        din = 8'hf1;

        #10
        en_in = 0;

	#40
        #10
        en_in = 1;
        din = 8'hff;

	#40
        #10
        en_in = 0;
        en_out = 1;

	#40
        #10
        en_in = 1;
        en_out = 0;
        din = 8'hee;

	#40
        #10
        en_in = 0;
        en_out = 1;

        #10
	en_out = 0;

        #10
	en_out = 1;

        #10
        en_out = 0;

        #20
        $finish;
    end
endmodule
