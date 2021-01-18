`timescale 1ns / 1ps
// ALU simulation
// 2020 COD Lab1
// ustcpetergu

module alu_simu();
    reg [3:0] a, b;
    reg [2:0] m;
    wire [3:0] y;
    wire zf, cf, of;

    alu #(.WIDTH(4)) alu_inst
    (
        .m(m), .a(a), .b(b), .y(y), .zf(zf), .cf(cf), .of(of)
    );

    initial begin
        m = 3'b000; // add
        a = 4'b0011;
        b = 4'b1100;

        #10;
        a = 4'b1000;
        b = 4'b1101;
        
        #10;
        a = 4'b0101;
        b = 4'b1001;
        
        #10;
        a = 4'b1111;
        b = 4'b0001;
                
        #10 m = 3'b001;	// sub

        #10;
        a = 4'b0011;
        b = 4'b1110;
        
        #10;
        a = 4'b1000;
        b = 4'b1101;
        
        #10;
        a = 4'b0101;
        b = 4'b1001;
        
        #10;
        a = 4'b0111;
        b = 4'b0111; 

        #10 m = 3'b010;	// and
        a = 4'b0011;
        b = 4'b0101;
        
        #10 m = 3'b011;	// or
        #10 m = 3'b100;	// xor
        #10 m = 3'b101;	// err
        #10;
        $finish;      
    end

endmodule
