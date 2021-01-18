`timescale 1ns / 1ps
// helloworld test on ebaz4205
// 2020 COD Lab 6
// ustcpetergu

module helloworldtest(
        input clk,

        input btndata1,
        input btndata2,

        output led_g,
        output led_r,
        output reg leddata1,
        output reg leddata2
    );

    reg [24:0]count = 0;
    always @ (posedge clk) begin
        count <= count + 1;
    end
    assign led_g = count[24];
    assign led_r = !count[24];

    always @ (posedge clk) begin
        leddata1 <= btndata1;
        leddata2 <= btndata2;
    end
endmodule
