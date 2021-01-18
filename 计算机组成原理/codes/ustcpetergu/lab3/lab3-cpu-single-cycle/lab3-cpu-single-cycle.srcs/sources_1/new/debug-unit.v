`timescale 1ns / 1ps
// single cycle CPU -- debug unit
// 2020 COD Lab3
// ustcpetergu

// 7-segment digital control
module seven_segment
    (
        input clk,
        input rst,
        input [31:0]x,
        output reg [7:0]an,
        output reg [6:0]seg
    );
    reg [31:0]count = 0;
    localparam UPDATE_COUNT = 100000;
    reg [2:0]select = 0;
    reg [3:0]x0;
    always @ (*) begin
        case (select)
            0: begin x0 = x[3:0]; an = 8'b11111110; end
            1: begin x0 = x[7:4]; an = 8'b11111101; end
            2: begin x0 = x[11:8]; an = 8'b11111011; end
            3: begin x0 = x[15:12]; an = 8'b11110111; end
            4: begin x0 = x[19:16]; an = 8'b11101111; end
            5: begin x0 = x[23:20]; an = 8'b11011111; end
            6: begin x0 = x[27:24]; an = 8'b10111111; end
            7: begin x0 = x[31:28]; an = 8'b01111111; end
            default: begin x0 = 0; an = 0; end
        endcase
        case (x0)
            // +7+
            // 2 6
            // +1+
            // 3 5
            // +4+
            0: seg = 7'b1000000;
            1: seg = 7'b1111001;
            2: seg = 7'b0100100;
            3: seg = 7'b0110000;
            4: seg = 7'b0011001;
            5: seg = 7'b0010010;
            6: seg = 7'b0000010;
            7: seg = 7'b1111000;
            8: seg = 7'b0000000;
            9: seg = 7'b0010000;
            10: seg = 7'b0001000;
            11: seg = 7'b0000011;
            12: seg = 7'b1000110;
            13: seg = 7'b0100001;
            14: seg = 7'b0000110;
            15: seg = 7'b0001110;
            default: seg = 0;
        endcase
    end
    always @ (posedge clk) begin
        if (rst)
            count <= 0;
        else if (count >= UPDATE_COUNT) begin
            count <= 0;
            select <= select + 1;
        end else
            count <= count + 1;
    end
endmodule

module debug_unit
    (
        // from human input
        input clk, 
        input rst,//BTNL
        input succ, // SW15
        input step, // BTNC
        input [2:0]sel, // SW2~SW0
        input m_rf, // SW3
        input inc, // BTNU
        input dec, // BTND

        // to human visible device
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

    reg run = 0;
    reg after_run = 0;
    reg [7:0]m_rf_addr = 0;

    wire step_real;
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

    // from CPU
    wire RegDst;
    wire Jump;
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire [2:0]ALUOp;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;

    wire [31:0]pc;
    wire [31:0]newpc;
    wire [31:0]instruction;

    wire [31:0]ReadData1;
    wire [31:0]ReadData2;
    wire [31:0]ReadData_ram;

    wire [31:0]ALUResult;
    wire Zero;

    wire [31:0]rf_data;
    wire [31:0]m_data;
    // saved signals
    reg RegDst_save;
    reg Jump_save;
    reg Branch_save;
    reg MemRead_save;
    reg MemtoReg_save;
    reg [2:0]ALUOp_save;
    reg MemWrite_save;
    reg ALUSrc_save;
    reg RegWrite_save;

    reg [31:0] pc_save;
    reg [31:0] newpc_save;
    reg [31:0] instruction_save;

    reg [31:0]ReadData1_save;
    reg [31:0]ReadData2_save;
    reg [31:0]ReadData_ram_save;

    reg [31:0]ALUResult_save;
    reg Zero_save;
    
    // m_data and rf_data don't need save
    //reg [31:0]rf_data_save;
    //reg [31:0]m_data_save;
    cpu_single_cyc cpu_single_cyc_inst 
    (
        .clk(clk),
        .rst(rst),
        .run_in(run),
        .RegDst(RegDst),
        .Jump(Jump),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .pc(pc),
        .newpc(newpc),
        .instruction(instruction),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2),
        .ALUResult(ALUResult),
        .Zero(Zero),
        .ReadData_ram(ReadData_ram),
        .m_rf_addr(m_rf_addr),
        .rf_data(rf_data),
        .m_data(m_data)
    );

    always @ (posedge clk) begin
        if (rst) begin
            m_rf_addr <= 0;
            run <= 0;
            after_run <= 0;
            led <= 16'b0;
            {RegDst_save, Jump_save, Branch_save, MemRead_save, MemtoReg_save, ALUOp_save, MemWrite_save, ALUSrc_save, RegWrite_save, pc_save, newpc_save, instruction_save, ReadData1_save, ReadData2_save, ReadData_ram_save, ALUResult_save, Zero_save} <= 236'b0;
        end
        else begin
            if (after_run) {RegDst_save, Jump_save, Branch_save, MemRead_save, MemtoReg_save, ALUOp_save, MemWrite_save, ALUSrc_save, RegWrite_save, pc_save, newpc_save, instruction_save, ReadData1_save, ReadData2_save, ReadData_ram_save, ALUResult_save, Zero_save} <= {RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, pc, newpc, instruction, ReadData1, ReadData2, ReadData_ram, ALUResult, Zero};

            if (inc_real) m_rf_addr <= m_rf_addr + 1;
            else if (dec_real) m_rf_addr <= m_rf_addr - 1;

            run <= step_real;
            after_run <= run;
            if (sel == 3'b0)
                led <= {8'b0, m_rf_addr};
            else
                led <= {4'b0, Jump_save, Branch_save, RegDst_save, RegWrite_save, MemRead_save, MemtoReg_save, MemWrite_save, ALUOp_save, ALUSrc_save, Zero_save};
            case (sel)
                0: begin
                    if (m_rf == 1) seg_data <= m_data; else seg_data = rf_data;
                end
                1: seg_data <= newpc_save;
                2: seg_data <= pc_save;
                3: seg_data <= instruction_save;
                4: seg_data <= ReadData1_save;
                5: seg_data <= ReadData2_save;
                6: seg_data <= ALUResult_save;
                7: seg_data <= ReadData_ram_save;
                default: seg_data <= 32'b0;
            endcase
        end
    end
endmodule

