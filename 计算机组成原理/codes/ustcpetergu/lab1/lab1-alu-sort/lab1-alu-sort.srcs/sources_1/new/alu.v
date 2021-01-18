`timescale 1ns / 1ps
// ALU
// 2020 COD Lab1
// ustcpetergu

module alu
    #(parameter WIDTH = 32)
    (
        input [2:0]m, // selection
        input [WIDTH-1:0]a, b, // input
        output [WIDTH-1:0]y, // result
        output zf, // zero flag
        output cf, // carry out flag: WIDTH bit
        output of // overflow flag: WIDTH-1 sign bit
    );

    reg [WIDTH-1:0]regy;
    reg regcf;
    reg regof;
    reg regzf;
    assign y = regy;
    assign cf = regcf;
    assign of = regof;
    assign zf = regzf;
    // assign zf = (regy == 0);

    always @ (a, b, m) begin
        case(m)
            3'b000: begin // add
                {regcf, regy} = a + b;
                regof = (!a[WIDTH-1] & !b[WIDTH-1] & regy[WIDTH-1]) |
                 (a[WIDTH-1] & b[WIDTH-1] & !regy[WIDTH-1]);
                regzf = (regy == 0);
            end
            3'b001: begin // sub
                {regcf, regy} = a - b;
                regof = (!a[WIDTH-1] & b[WIDTH-1] & regy[WIDTH-1]) |
                 (a[WIDTH-1] & !b[WIDTH-1] & !regy[WIDTH-1]);
                regzf = (regy == 0);
            end
            3'b010: begin // and
                regy = a & b;
                regzf = (regy == 0);
                regcf = 0;
                regof = 0;
            end
            3'b011: begin // or
                regy = a | b;
                regzf = (regy == 0);
                regcf = 0;
                regof = 0;
            end
            3'b100: begin // xor
                regy = a ^ b;
                regzf = (regy == 0);
                regcf = 0;
                regof = 0;
            end
            default: begin // error
                regy = 0;
                regzf = 0;
                regcf = 0;
                regof = 0;
            end
        endcase
    end
endmodule
