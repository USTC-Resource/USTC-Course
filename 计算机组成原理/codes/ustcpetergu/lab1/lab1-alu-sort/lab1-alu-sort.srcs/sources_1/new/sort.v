`timescale 1ns / 1ps
// sort
// 2020 COD Lab1
// ustcpetergu

module sort
    #(parameter N = 4)
    (
        input [N-1:0]i1, i2, i3, i4,
        input clk, rst,
        output reg [N-1:0]o1, o2, o3, o4,
        output reg done
    );

    reg [N-1:0]a, b;
    wire [2:0]m = 3'b001; // minus
    wire of;
    wire zf;
    wire [N-1:0]y;
    wire sf;
    assign sf = y[N-1];
    assign gt = (~of & ~sf & ~zf) | (of & sf & ~zf);
    alu #(.WIDTH(N)) alu_inst
    (
        .m(m),
        .a(a),
        .b(b),
        .of(of),
        .zf(zf),
        .y(y)
    );

    reg [3:0]curr_state;
    // reg [3:0]next_state;

    always @ (posedge clk) begin
        if (rst) begin 
            done <= 0;
            curr_state <= 4'b0000;
        end
        // curr_state <= next_state;
        else begin case (curr_state)
            4'b0000: begin
                o1 <= i1;
                o2 <= i2;
                o3 <= i3;
                o4 <= i4;
                a <= i1;
                b <= i2;
                curr_state <= 4'b0001;
            end
            4'b0001: begin
                if (gt) begin
                    o1 <= o2;
                    a <= o2;
                    o2 <= o1;
                end
                else a <= o1;
                b <= o3;
                curr_state <= 4'b0010;
            end
            4'b0010: begin
                if (gt) begin
                    o1 <= o3;
                    a <= o3;
                    o3 <= o1;
                end
                else a <= o1;
                b <= o4;
                curr_state <= 4'b0011;
            end
            4'b0011: begin
                if (gt) begin
                    o1 <= o4;
                    o4 <= o1;
                    // now o1 contains maximum
                end
                a <= o2;
                b <= o3;
                curr_state <= 4'b0100;
            end
            4'b0100: begin
                if (gt) begin
                    o2 <= o3;
                    a <= o3;
                    o3 <= o2;
                end
                else a <= o2;
                b <= o4;
                curr_state <= 4'b0101;
            end
            4'b0101: begin
                if (gt) begin
                    o2 <= o4;
                    o4 <= o2;
                    // now o2 contains second-max
                end
                a <= o3;
                b <= o4;
                curr_state <= 4'b0110;
            end
            4'b0110: begin
                if (gt) begin
                    o3 <= o4;
                    o4 <= o3;
                    // in order now
                end
                done <= 1;
                curr_state <= 4'b0111;
            end
            4'b0111: begin
                curr_state <= 4'b0111;
            end
        endcase
        end
    end

    // reg [N-1:0]t;
    // always @ (*) begin
    //     case (curr_state)
    //         4'b0000: begin 
    //             done = 0;
    //             o1 = i1;
    //             o2 = i2;
    //             o3 = i3;
    //             o4 = i4;
    //             a = o1;
    //             b = o2;
    //             next_state = 4'b0001;
    //         end
    //         4'b0001: begin
    //             if (cf == 1) begin
    //                 t = o1;
    //                 o1 = o2;
    //                 o2 = t;
    //             end
    //             a = o1;
    //             b = o3;
    //             next_state = 4'b0010;
    //         end
    //         4'b0010: begin
    //             if (cf == 1) begin
    //                 t = o1;
    //                 o1 = o3;
    //                 o3 = t;
    //             end
    //             a = o1;
    //             b = o4;
    //             next_state = 4'b0011;
    //         end
    //         4'b0011: begin
    //             // if (cf == 1) begin
    //             // end else b = i3;
    //             // next_state = 4'b0100;
    //         end
    //         4'b1111: next_state = 4'b1111;
    //         default: next_state = 4'b1111;
    //     endcase
    // end
endmodule
