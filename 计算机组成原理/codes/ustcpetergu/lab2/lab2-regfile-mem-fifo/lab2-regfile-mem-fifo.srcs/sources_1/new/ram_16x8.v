`timescale 1ns / 1ps
// RAM
// 2020 COD Lab2
// ustcpetergu

module ram_16x8
    (
        input clk,
        input en, we,
        input [3:0]addr, // depth: 16
        input [7:0]din, // data width: 8
        output [7:0]dout
    );

    reg [3:0]addr_reg;
    reg [7:0]mem[15:0];

    initial $readmemb("/home/petergu/MyHome/COD/lab2/mem.dat", mem);

    assign dout = mem[addr_reg];

    always @ (posedge clk) begin
        if (en) begin
            addr_reg <= addr;
            if (we) begin
                mem[addr] <= din;
            end
        end
    end

endmodule

