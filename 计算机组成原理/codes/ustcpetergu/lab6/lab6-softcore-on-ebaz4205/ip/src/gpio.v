`timescale 1ns / 1ps

module gpio
    (
        input clk,
        input rst,
        input [1:0]a,
        input [31:0]d,
        input we,
        output reg [31:0]spo,

        input [1:0]btn,
        output reg [1:0]led
    );

    always @ (*) begin
        case (a)
            0: spo = {31'b0, btn[0]};
            1: spo = {31'b0, btn[1]};
            2: spo = {31'b0, led[0]};
            3: spo = {31'b0, led[1]};
            default: spo = 32'b0;
        endcase
    end

    always @ (posedge clk) begin
        if (rst) begin
            led <= 2'b11;
        end
        else if (we) begin
            case (a)
                2: led[0] <= d[0];
                3: led[1] <= d[0];
                default: ;
            endcase
        end
    end
endmodule
