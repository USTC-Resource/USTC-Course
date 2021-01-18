`timescale 1ns / 1ps
// pipeline CPU simu
// 2020 COD Lab5
// ustcpetergu

module cpu_pipeline_simu();
    reg clk;
    reg rst;

    cpu_pipeline cpu_pipeline_inst
    (
        .clk(clk),
        .rst(rst),
        .m_rf_addr(0)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        rst = 1;
        #10
        rst = 0;
        #1000
        $finish;
    end
endmodule
