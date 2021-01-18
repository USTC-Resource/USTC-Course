`timescale 1ns / 1ps
// edgefetcher
// 2020 COD Lab
// ustcpetergu


module edgefetcher
    (
        input clk, rst,
        input y,
        output p
    );
    reg [1:0]state, next_state; 
    assign p = (state == 1);
    always @ (posedge clk) begin
        if (rst) state <= 0;
        else state <= next_state;
    end
    always @ (*) begin
        next_state = state;
        case (state)
            0: if (y) next_state = 1;
            1: if (y) next_state = 2; else next_state = 0;
            2: if (y) next_state = 2; else next_state = 0;
            default: next_state = 0;
        endcase
    end
endmodule

