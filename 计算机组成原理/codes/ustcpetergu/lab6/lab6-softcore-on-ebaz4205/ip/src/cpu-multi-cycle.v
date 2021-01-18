`timescale 1ns / 1ps

module cpu_multi_cycle
    (
        input clk,
        input rst,

        output reg [31:0]a,
        output reg [31:0]d,
        output reg we,
        input [31:0]spo
    );

    // internal registers
    reg [31:0]instruction = 0;
    reg [31:0]pc = 0;
    reg [31:0]mdr = 0;
    reg [31:0]ALUOut = 0;
    reg [31:0]A = 0;
    reg [31:0]B = 0;

    // some signals
    wire ALUZero;
    reg [31:0]newpc;
    wire [31:0]imm = {{16{instruction[15]}}, instruction[15:0]};

    // control unit signals
    wire PCWrite;
    wire IorD;
    wire MemRead;
    wire MemWrite;
    wire [2:0]RegSrc;
    wire IRWrite;
    wire [2:0]PCSource;
    wire [2:0]ALUm;
    wire ALUSrcA;
    wire [1:0]ALUSrcB;
    wire RegWrite;
    wire [1:0]RegDst;
    control_unit control_unit_inst
    (
        .clk(clk),
        .rst(rst),
        .instruction(instruction),
        .ALUZero(ALUZero),

        .PCWrite(PCWrite),
        .IorD(IorD),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .RegSrc(RegSrc),
        .IRWrite(IRWrite),
        .PCSource(PCSource),
        .ALUm(ALUm),
        .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB),
        .RegWrite(RegWrite),
        .RegDst(RegDst)
    );

    // register file
    reg [4:0]WriteRegister;
    reg [31:0]WriteData;
    wire [31:0]ReadData1;
    wire [31:0]ReadData2;
    register_file register_file_inst
    (
        .clk(clk),
        .ra0(instruction[25:21]),
        .ra1(instruction[20:16]),
        .wa(WriteRegister),
        .we(RegWrite),
        .wd(WriteData),
        .rd0(ReadData1),
        .rd1(ReadData2)
    );

    // memory mapper
    reg [31:0]mem_addr;
    reg [31:0]MemData;
    always @ (*) begin
        a = mem_addr;
        d = B;
        we = MemWrite;
        MemData = spo;
    end

    // ALU
    reg [31:0]ALUIn1;
    reg [31:0]ALUIn2;
    wire [31:0]ALUResult;
    alu alu_inst
    (
        .m(ALUm),
        .a(ALUIn1),
        .b(ALUIn2),
        .y(ALUResult),
        .zf(ALUZero)
        //.cf(),
        //.of()
    );

    // datapath -- main
    always @ (*) begin
        case (IorD)
            0: mem_addr = pc;
            1: mem_addr = ALUOut;
        endcase
        case (RegDst)
            0: WriteRegister = instruction[20:16];
            1: WriteRegister = instruction[15:11];
            2: WriteRegister = 5'b11111;
        endcase
        case (RegSrc)
            0: WriteData = ALUOut;
            1: WriteData = mdr;
            2: WriteData = {instruction[15:0], 16'b0};
            3: WriteData = pc;
        endcase
        case (ALUSrcB)
            0: ALUIn2 = B;
            1: ALUIn2 = 4;
            2: ALUIn2 = imm;
            3: ALUIn2 = imm << 2;
        endcase
        case (ALUSrcA)
            0: ALUIn1 = pc;
            1: ALUIn1 = A;
        endcase
        case (PCSource)
            0: newpc = ALUResult;
            1: newpc = ALUOut;
            2: newpc = {pc[31:28], instruction[25:0], 2'b0};
            3: newpc = A;
        endcase
    end
    always @ (posedge clk) begin
        if (rst) begin
            pc <= 32'b0;
            instruction <= 0;
            mdr <= 0;
            ALUOut <= 0;
            A <= 0;
            B <= 0;
        end
        else begin
            A <= ReadData1;
            B <= ReadData2;
            ALUOut <= ALUResult;
            mdr <= MemData;
            if (PCWrite) pc <= newpc;
            if (IRWrite) instruction <= MemData;
        end
    end
endmodule
