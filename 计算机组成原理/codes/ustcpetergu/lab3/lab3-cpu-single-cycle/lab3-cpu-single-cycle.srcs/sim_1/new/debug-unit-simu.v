`timescale 1ns / 1ps
// single cycle CPU DBU simu
// 2020 COD Lab3
// ustcpetergu

module debug_unit_simu();
    reg clk, rst;

    reg succ;
    reg step;
    reg [2:0]sel;
    reg m_rf;
    reg inc;
    reg dec;
    wire [15:0]led;
    wire an;
    wire seg;
    wire [31:0]seg_data;
    debug_unit debug_unit_inst
    (
        .clk(clk),
        .rst(rst),
        .succ(succ),
        .step(step),
        .sel(sel),
        .m_rf(m_rf),
        .inc(inc),
        .dec(dec),

        .led(led),
        .an(an),
        .seg(seg),

        .seg_data(seg_data)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 0;

        #10
        rst = 1;
        succ = 0;
        step = 0;
        sel = 1;
        m_rf = 0;
        inc = 0;
        dec = 0;

        #10
        rst = 0;
        step = 1;
        #10
        step = 0;
        #10
        step = 1;
        #10
        step = 0;

        #50
        sel = 2;
        #10
        sel = 3;
        #10
        sel = 4;
        #10
        sel = 5;
        #10
        sel = 6;
        #10
        sel = 7;

        //#10
        //step = 1;
        //#30
        //step = 0;
        
        #10
        sel = 0;
        inc = 1;
        #10
        inc = 0;
        #10
        inc = 1;
        #10
        inc = 0;

        #30
        m_rf = 1;
        dec = 1;
        #10
        dec = 0;
        #10
        dec = 1;
        #10
        dec = 0;

        #40
        $finish;
    end
endmodule
