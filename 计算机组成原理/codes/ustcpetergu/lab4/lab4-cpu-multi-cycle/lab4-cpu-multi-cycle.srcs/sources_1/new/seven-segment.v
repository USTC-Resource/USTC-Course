`timescale 1ns / 1ps
// 7-segment digital control
// 2020 COD Lab
// ustcpetergu

module seven_segment
    (
        input clk,
        input rst,
        input [31:0]x,
        output reg [7:0]an,
        output reg [6:0]seg
    );
    reg [31:0]count = 0;
    localparam UPDATE_COUNT = 100000;
    reg [2:0]select = 0;
    reg [3:0]x0;
    always @ (*) begin
        case (select)
            0: begin x0 = x[3:0]; an = 8'b11111110; end
            1: begin x0 = x[7:4]; an = 8'b11111101; end
            2: begin x0 = x[11:8]; an = 8'b11111011; end
            3: begin x0 = x[15:12]; an = 8'b11110111; end
            4: begin x0 = x[19:16]; an = 8'b11101111; end
            5: begin x0 = x[23:20]; an = 8'b11011111; end
            6: begin x0 = x[27:24]; an = 8'b10111111; end
            7: begin x0 = x[31:28]; an = 8'b01111111; end
            default: begin x0 = 0; an = 0; end
        endcase
        case (x0)
            // +7+
            // 2 6
            // +1+
            // 3 5
            // +4+
            0: seg = 7'b1000000;
            1: seg = 7'b1111001;
            2: seg = 7'b0100100;
            3: seg = 7'b0110000;
            4: seg = 7'b0011001;
            5: seg = 7'b0010010;
            6: seg = 7'b0000010;
            7: seg = 7'b1111000;
            8: seg = 7'b0000000;
            9: seg = 7'b0010000;
            10: seg = 7'b0001000;
            11: seg = 7'b0000011;
            12: seg = 7'b1000110;
            13: seg = 7'b0100001;
            14: seg = 7'b0000110;
            15: seg = 7'b0001110;
            default: seg = 0;
        endcase
    end
    always @ (posedge clk) begin
        if (rst)
            count <= 0;
        else if (count >= UPDATE_COUNT) begin
            count <= 0;
            select <= select + 1;
        end else
            count <= count + 1;
    end
endmodule

