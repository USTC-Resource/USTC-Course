`timescale 1ns / 1ps

module top_simu();
    reg clk = 0;
    reg [1:0]btn = 0;
    wire [1:0]led;

    bd_main_wrapper bd_main_wrapper_inst
    (
        .sysclk(clk),
        .btndata(btn),
        .leddata(led)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        btn = 2'b11;
        #200
        btn = 2'b00;
        //#10
        //btn = 4'b0000;

        //#1000
        //btn = 4'b0010;

        #3000
        $finish;
    end
    
endmodule
