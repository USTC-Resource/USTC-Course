`timescale 1ns / 1ps
// single cycle CPU simu
// 2020 COD Lab3
// ustcpetergu


module cpu_single_cyc_simu();
    reg clk;
    reg rst;
    reg run;

    reg [7:0]m_rf_addr;

    wire  RegDst;
    wire  Jump;
    wire  Branch;
    wire  MemRead;
    wire  MemtoReg;
    wire  [2:0]ALUOp;
    wire  MemWrite;
    wire  ALUSrc;
    wire  RegWrite;

    wire  [31:0] pc;
    wire  [31:0] newpc;
    wire [31:0] instruction;

    wire [31:0]ReadData1;
    wire [31:0]ReadData2;
    wire [31:0]ReadData_ram;

    wire [31:0]ALUResult;
    wire Zero;

    wire [31:0]rf_data;
    wire [31:0]m_data;

    wire [31:0]imm;
    wire [31:0]alu_b;
    wire run_real;
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
        .ReadData_ram(ReadData_ram),
        .ALUResult(ALUResult),
        .Zero(Zero),
        .m_rf_addr(m_rf_addr),
        .rf_data(rf_data),
        .m_data(m_data),
        .imm(imm),
        .alu_b(alu_b),
        .run(run_real)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        run = 1;
        m_rf_addr = 8'b0;

        #10
        rst = 0;
        #75
        run = 0;
        #11
        run = 1;
        #10
        run = 0;
        #19
        run = 1;
        #25
        rst = 1;
        #10
        rst = 0;
        #100
        $finish;
    end
endmodule

