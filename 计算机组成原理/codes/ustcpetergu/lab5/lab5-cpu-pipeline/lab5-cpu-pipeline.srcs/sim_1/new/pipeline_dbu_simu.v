`timescale 1ns / 1ps
// pipeline cycle CPU -- DBU simu
// 2020 COD Lab5
// ustcpetergu


module pipeline_dbu_simu();
    reg clk, rst;

    reg succ;
    reg step;
    reg [2:0]sel;
    reg [1:0]sel2;
    reg m_rf;
    reg inc;
    reg dec;
    wire [15:0]led;
    wire an;
    wire seg;
    wire [31:0]seg_data;

    pipeline_dbu pipeline_dbu_inst
    (
        .clk(clk),
        .rst(rst),
        .succ(succ),
        .step(step),
        .sel(sel),
        .sel2(sel2),
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
        rst = 1;
        #10
        rst = 0;
        //#1000
        rst = 1;
        succ = 0;
        step = 0;
        sel = 1;
        sel2 = 0;
        m_rf = 0;
        inc = 0;
        dec = 0;

        #40
        rst = 0;
        step = 1;
        #10
        step = 0;
        #10
        step = 1;
        #10
        step = 0;
        #10
        step = 1;
        #10
        step = 0;
        #10
        step = 1;
        #10
        step = 0;
        #10
        step = 1;
        #10
        step = 0;
        #10
        step = 1;
        #10
        step = 0;
        #10
        step = 1;
        #10
        step = 0;
        #10
        step = 1;
        #10
        step = 0;
        #10
        step = 1;
        #10
        step = 0;
        #10
        step = 1;
        #10
        step = 0;

        #50
        sel = 2;
        sel2 = 0;
        #10
        sel2 = 1;
        #10
        sel2 = 2;
        #10
        sel2 = 3;
        #10
        sel2 = 0;
        sel = 3;
        #10
        sel = 4;
        #10
        sel = 5;

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
