`timescale 1ns / 1ps
// input button debounce
// https://timetoexplore.net/blog/arty-fpga-verilog-03

module debounce
    #(parameter N = 2)
    (
        input clk,
        input [N-1:0]i_btn,
        output reg [N-1:0]o_state = 0
        //output o_ondn,
        //output o_onup
    );

    // sync with clock and combat metastability
    reg [N-1:0]sync_0 = 0;
    reg [N-1:0]sync_1 = 0;
    always @(posedge clk) sync_0 <= i_btn;
    always @(posedge clk) sync_1 <= sync_0;

    // 2.6 ms counter at 100 MHz
    reg [18:0] counter;
    wire idle = (o_state == sync_1);
    wire [18:0]max = 10;

    always @(posedge clk)
    begin
        if (idle)
            counter <= 0;
        else
        begin
            counter <= counter + 1;
            if (counter == max)
                o_state <= sync_1;
        end
    end

    //assign o_ondn = ~idle & max & ~o_state;
    //assign o_onup = ~idle & max & o_state;
endmodule
//module debounce
    //#(parameter N = 4)
    //(
        //input clk,
        //input [N-1:0]i_btn,
        //output reg [N-1:0]o_state = 0
        ////output o_ondn,
        ////output o_onup
    //);

    //// sync with clock and combat metastability
    //reg [N-1:0]sync_0 = 0;
    //reg [N-1:0]sync_1 = 0;
    //always @(posedge clk) sync_0 <= i_btn;
    //always @(posedge clk) sync_1 <= sync_0;

    //// 2.6 ms(*2) counter at 100 MHz
    //reg [18:0] counter = 0;
    ////reg [19:0] counter;
    //wire idle = (o_state == sync_1);

    //always @(posedge clk)
    //begin
        //if (idle)
            //counter <= 0;
        //else
        //begin
            //counter <= counter + 1;
            //if (counter == 19'b11111)
                ////o_state <= ~o_state;
                //o_state <= sync_1;
        //end
    //end

    ////assign o_ondn = ~idle & max & ~o_state;
    ////assign o_onup = ~idle & max & o_state;
//endmodule
