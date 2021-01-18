`timescale 1ns / 1ps
// regfile
// 2020 COD Lab2
// ustcpetergu

module register_file
    #(parameter WIDTH = 32)
    (
        input clk,
        input [4:0]ra0,
        input [4:0]ra1,
        input [4:0]wa,
        input we,
        input [WIDTH-1:0]wd,
        output reg [WIDTH-1:0]rd0,
        output reg [WIDTH-1:0]rd1
    );

    reg [WIDTH-1:0]regfile[31:0];
    initial $readmemh("/home/petergu/MyHome/COD/lab2/regfile.dat", regfile);

    always @ (*) begin
        if (ra0 == 5'b0) rd0 = 0;
        else rd0 = regfile[ra0];
        if (ra1 == 5'b0) rd1 = 0;
        else rd1 = regfile[ra1];
    end

    always @ (posedge clk) begin
        if (we) begin
            if (wa != 5'b0) begin
                regfile[wa] <= wd;
            end
        end
    end

endmodule

