`timescale 1ns / 1ps
// multiple cycle CPU simu
// 2020 COD Lab4
// ustcpetergu

module cpu_multi_cycle_simu();
    reg clk;
    reg rst;

    cpu_multi_cycle cpu_multi_cycle_inst
    (
        .clk(clk),
        .rst(rst),
        .m_rf_addr(9'b0)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        rst = 1;

        #10
        rst = 0;

        #400
        //rst = 1;
        //#10
        //rst = 0;

        #400
        $finish;
    end
endmodule
