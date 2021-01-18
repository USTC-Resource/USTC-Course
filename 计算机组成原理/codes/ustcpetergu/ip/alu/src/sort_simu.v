`timescale 1ns / 1ps
// sort simulation
// 2020 COD Lab1
// ustcpetergu

module sort_simu();
    reg clk, rst;
    reg [3:0] i1, i2, i3, i4;
    wire [3:0] o1, o2, o3, o4;
    wire done;

    sort #(.N(4)) sort_inst
    (
        .i1(i1),
        .i2(i2),
        .i3(i3),
        .i4(i4),
        .clk(clk),
        .rst(rst),
        .o1(o1),
        .o2(o2),
        .o3(o3),
        .o4(o4),
        .done(done)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin 
        i1 = 9;
        i2 = 3;
        i3 = 8;
        i4 = 1;
        rst = 1;
        #10
        rst = 0;

        #(10 * 7)

        rst = 1;
        #10
        rst = 0;
        
        i1 = 8;
        i2 = 10;
        i3 = 15;
        i4 = 11;
        #(10 * 7)

        rst = 1;
        #10
        rst = 0;

        i1 = 4;
        i2 = 3;
        i3 = 2;
        i4 = 1;
        #(10 * 7)

        #10
        $finish;
    end

endmodule
