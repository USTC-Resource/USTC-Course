`timescale 1ns / 1ps
// fifo
// 2020 COD Lab2
// ustcpetergu

module mux21
    #(parameter N = 8)
    (
        input [N-1:0]a,
        input [N-1:0]b,
        input sel,
        output reg [N-1:0]o
    );
    always @ (*) begin
        if (sel == 0) o = a;
        else o = b;
    end
endmodule

module fifo
    (
        input clk, rst,
        input [7:0]din,
        input en_in, 
        input en_out,
        output en_in_in,
        output en_out_in,
        output [7:0]dout,
        output reg [4:0]count = 0
    );

    reg [3:0]head = 4'b0;
    reg [3:0]tailp1 = 4'b0;
    wire [3:0]head_wire;
    wire [3:0]tailp1_wire;
    wire [4:0]count_wire;
    wire [3:0]head_wire_rst;
    wire [3:0]tailp1_wire_rst;
    wire [4:0]count_wire_rst;

    wire we;
    wire [3:0]a;
    dist_mem_gen_0 dist_mem_gen_0_inst (
        .clk(clk),
        .we(we),
        .a(a),
        .d(din),
        .spo(dout)
    );

    //wire en_in_in, en_out_in;
    edgefetcher edgefetcher_inst_1 (
        .clk(clk),
        .rst(rst),
        .y(en_in),
        .p(en_in_in)
    );
    edgefetcher edgefetcher_inst_2 (
        .clk(clk),
        .rst(rst),
        .y(en_out),
        .p(en_out_in)
    );

    wire en_in_real = en_in_in & (count != 5'b11111);
    wire en_out_real = en_out_in & (count != 5'b0);

    // we port selection
    mux21 #(1) mux21_1 (1'b0, 1'b1, en_in_real, we);
    // addr: part it at head if no enqueue
    mux21 #(4) mux21_2 (head, tailp1, en_in_real, a);
    // tail++,count++ if enqueue, head++,count-- if dequeue
    mux21 #(4) mux21_3 (tailp1, tailp1 + 1, en_in_real, tailp1_wire);
    mux21 #(4) mux21_3_rst (tailp1_wire, 4'b1, rst, tailp1_wire_rst);
    mux21 #(4) mux21_4 (head, head + 1, en_out_real, head_wire);
    mux21 #(4) mux21_4_rst (head_wire, 4'b0, rst, head_wire_rst);
    wire [4:0]countpm;
    mux21 #(5) mux21_5 (count + 1, count - 1, en_out_real, countpm);
    mux21 #(5) mux21_6 (count, countpm, en_in_real | en_out_real, count_wire);
    mux21 #(5) mux21_6_rst (count_wire, 5'b0, rst, count_wire_rst);
    always @ (posedge clk) begin
        tailp1 <= tailp1_wire_rst;
        head <= head_wire_rst;
        count <= count_wire_rst;
    end

endmodule

