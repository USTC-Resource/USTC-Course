`timescale 1ns / 1ps
// regfile simu
// 2020 COD Lab2
// ustcpetergu


module regfile_simu();
    reg clk;
    reg [4:0]ra0, ra1;
    reg [4:0]wa;
    reg we;
    reg [31:0]wd;
    wire [31:0]rd0, rd1;

    register_file register_file_inst
    (
        .clk(clk),
        .ra0(ra0),
        .ra1(ra1),
        .wa(wa),
        .we(we),
        .wd(wd),
        .rd0(rd0),
        .rd1(rd1)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        ra0 = 1;
        ra1 = 2;
        wa = 0;
        we = 0;
        wd = 0;

        #5
        ra0 = 3;
        ra1 = 4;

        #5
        we = 1;
        wa = 1;
        wd = 32'hff;

        #10
        wa = 2;
        wd = 32'hee;

        #10
        we = 0;
        ra0 = 1;
        ra1 = 2;

        #20
        $finish;
    end

endmodule
