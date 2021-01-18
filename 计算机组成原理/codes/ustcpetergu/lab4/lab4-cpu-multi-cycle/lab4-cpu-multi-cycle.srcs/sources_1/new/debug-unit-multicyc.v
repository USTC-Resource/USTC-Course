`timescale 1ns / 1ps
// multiple cycle CPU -- DBU
// 2020 COD Lab4
// ustcpetergu

module debug_unit_multicyc
    (
        input clk,
        input rst,
        input succ, 
        input step,
        input [2:0]sel,
        input m_rf,
        input inc, 
        input dec, 

        output reg [15:0]led = 0,
        output wire [7:0]an,
        output wire [6:0]seg,

        output reg [31:0]seg_data = 0
    );

    seven_segment seven_segment_inst 
    (
        .clk(clk),
        .rst(rst),
        .x(seg_data),
        .an(an),
        .seg(seg)
    );

    wire step_real;
    reg step_real_old;
    wire inc_real;
    wire dec_real;

    edgefetcher_0 edgefetcher_inst_0
    (
        .clk(clk),
        .rst(rst),
        .y(step),
        .p(step_real)
    );
    edgefetcher_0 edgefetcher_inst_1
    (
        .clk(clk),
        .rst(rst),
        .y(inc),
        .p(inc_real)
    );
    edgefetcher_0 edgefetcher_inst_2
    (
        .clk(clk),
        .rst(rst),
        .y(dec),
        .p(dec_real)
    );

    reg dclk = 0;
    reg [8:0]m_rf_addr = 0;
    wire [31:0]m_data;
    wire [31:0]rf_data;

    wire [1:0]PCSource;
    wire PCwe;
    wire IorD;
    wire MemWrite;
    wire IRWrite;
    wire RegDst;
    wire MemtoReg;
    wire RegWrite;
    wire [2:0]ALUm;
    wire ALUSrcA;
    wire [1:0]ALUSrcB;
    wire ALUZero;

    wire [31:0]pc;
    //wire [31:0]newpc;
    wire [31:0]instruction;
    wire [31:0]mdr;
    wire [31:0]A;
    wire [31:0]B;
    wire [31:0]ALUOut;
    
    cpu_multi_cycle cpu_multi_cycle_inst
    (
        .clk(dclk),
        .rst(rst),

        .instruction(instruction),
        .pc(pc),
        .mdr(mdr),
        .ALUOut(ALUOut),
        .A(A),
        .B(B),

        .PCSource(PCSource),
        .PCwe(PCwe),
        .IorD(IorD),
        .MemWrite(MemWrite),
        .IRWrite(IRWrite),
        .RegDst(RegDst),
        .MemtoReg(MemtoReg),
        .RegWrite(RegWrite),
        .ALUm(ALUm),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .ALUZero(ALUZero),

        .m_rf_addr(m_rf_addr),
        .rf_data(rf_data),
        .m_data(m_data)
    );

    always @ (posedge clk) begin
        if (rst) begin
            m_rf_addr <= 0;
            dclk <= 0;
            led <= 16'b0;
            step_real_old <= 0;
        end
        else begin
            if (succ == 1) begin dclk <= !dclk; end
            else begin
                if (step_real) dclk <= !dclk;
                else if (step_real_old) dclk <= !dclk;
            end

            step_real_old <= step_real;

            if (inc_real) m_rf_addr <= m_rf_addr + 1;
            else if (dec_real) m_rf_addr <= m_rf_addr - 1;

            if (sel == 3'b0)
                led <= {7'b0, m_rf_addr};
            else
                led <= {PCSource, PCwe, IorD, MemWrite, IRWrite, RegDst, MemtoReg, RegWrite, ALUm, ALUSrcA, ALUSrcB, ALUZero};
            case (sel)
                0: begin 
                    if (m_rf == 1) seg_data <= m_data; else seg_data <= rf_data;
                end
                1: seg_data <= pc;
                2: seg_data <= instruction;
                3: seg_data <= mdr;
                4: seg_data <= A;
                5: seg_data <= B;
                6: seg_data <= ALUOut;
                default: seg_data <= 32'b0;
            endcase
        end
    end

endmodule

