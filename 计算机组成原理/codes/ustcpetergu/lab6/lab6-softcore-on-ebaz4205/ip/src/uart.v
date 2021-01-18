`timescale 1ns / 1ps
// pComputer UART I/O
// input XXMHz, 16x oversampling
// warning: not very reliable: read/write together case, ...
// so need special software care(better to write one value and wait until idle)
//
// write 0x00: transmit data
// read 0x00: received data
// write 0x01: begin receiving
// read 0x01: receive done?
// read 0x02: transmit done?
// *need to x4 these addresses in assembly!

module uart
    (
        input clk,
        input rst,

        input [2:0]a,
        input [31:0]d,
        input we,
        output reg [31:0]spo,

        //output wire read_enabled_out,
        //output wire rx_state_out0,
        //output wire rx_state_out1,
        
        input rx,
        output reg tx = 1
    );

    wire rxclk_en;
    wire txclk_en;
    baud_rate_gen baud_rate_gen_inst
    (
        .clk(clk),
        .rst(rst),
        .rxclk_en(rxclk_en),
        .txclk_en(txclk_en)
    );

    localparam IDLE = 3'b000;
    //localparam PREPARE1 = 3'b001;
    //localparam PREPARE2 = 3'b010;
    localparam START = 3'b011;
    localparam DATA = 3'b100;
    localparam STOP = 3'b101;
    reg [2:0]state_tx = IDLE;
    reg [7:0]data_tx = 8'h00;
    reg [2:0]bitpos_tx = 0;

    localparam RX_STATE_START = 2'b01;
    localparam RX_STATE_DATA = 2'b10;
    localparam RX_STATE_STOP = 2'b11;
    reg [1:0]state_rx = RX_STATE_START;
    //assign rx_state_out0 = state_rx[0];
    //assign rx_state_out1 = state_rx[1];
    reg [3:0]sample = 0;
    reg [3:0]bitpos_rx = 0;
    reg [7:0]scratch = 8'b0;

    reg read_enabled = 0;
    reg [7:0]data_rx = 0;
    //reg [7:0]data_rx_ready = 0;

    always @ (*) begin
        if (a == 3'b000) spo = {24'b0, data_rx};
        else if (a == 3'b001) spo = {31'b0, !read_enabled};
        else if (a == 3'b010) spo = {31'b0, (state_tx == IDLE)};
        else spo = 32'b0;
    end
    always @ (posedge clk) begin
        if (rst) begin
            tx <= 1'b1;
            data_tx <= 0;
            bitpos_tx <= 0;
            state_tx <= IDLE;

            data_rx <= 0;
            read_enabled <= 0;
            //data_rx_ready <= 0;
            state_rx <= RX_STATE_START;
            sample <= 0;
        end
        else begin
            //if (we) begin
                //if (a == 3'b011 & d[0]) begin
                    //// so no way to set this to 0(cancel reading)!
                    //read_enabled <= 1;
                //end
                //if (a == 3'b000 & !fifo_full) begin
                //if (a == 3'b000 & !tx_write) begin
                    ////fifo_enqueue <= 1;
                    ////fifo_in <= d[7:0];
                    //data_tx <= d[7:0];
                //end
                //else begin
                    //fifo_enqueue <= 0;
                    //fifo_in <= 8'b0;
                //end
            //end
            case (state_tx) 
                IDLE: if (we & (a == 3'b000)) begin
                    data_tx <= d[7:0];
                    state_tx <= START;
                end
                START: if (txclk_en) begin
                    bitpos_tx <= 0;
                    tx <= 1'b0;
                    state_tx <= DATA;
                end
                DATA: if (txclk_en) begin
                    if (bitpos_tx == 7) state_tx <= STOP;
                    else bitpos_tx <= bitpos_tx + 1;
                    tx <= data_tx[bitpos_tx];
                end
                STOP: if (txclk_en) begin
                    tx <= 1'b1;
                    state_tx <= IDLE;
                end
                default: ;
            endcase

            if (we & a == 3'b001) begin
                read_enabled <= 1;
            end
            else if (rxclk_en) begin
                case (state_rx)
                    /*
                    Start counting from the first low sample, once we've
                    sampled a full bit, start collecting data bits.
                    */
                    RX_STATE_START: begin
                        //data_rx_ready <= 0;
                        if (!rx || sample != 0) sample <= sample + 1;
                        if (sample == 15) begin
                            state_rx <= RX_STATE_DATA;
                            bitpos_rx <= 0;
                            sample <= 0;
                            scratch <= 0;
                        end
                    end
                    RX_STATE_DATA: begin
                        sample <= sample + 1;
                        if (sample == 8) begin
                            scratch[bitpos_rx[2:0]] <= rx;
                            bitpos_rx <= bitpos_rx + 1;
                        end
                        if (bitpos_rx == 8 && sample == 15) state_rx <= RX_STATE_STOP;
                    end
                    /*
                     Our baud clock may not be running at exactly the
                     same rate as the transmitter.  If we thing that
                     we're at least half way into the stop bit, allow
                     transition into handling the next start bit.
                     */
                    RX_STATE_STOP: begin
                        if (sample == 15 || (sample >= 8 && !rx)) begin
                            state_rx <= RX_STATE_START;
                            data_rx <= scratch;
                            //data_rx_ready <= 1;
                            read_enabled <= 0;
                            sample <= 0;
                        end else begin
                            sample <= sample + 1;
                        end
                    end
                    default: state_rx <= RX_STATE_START;
                endcase
            end


        end
    end
endmodule
