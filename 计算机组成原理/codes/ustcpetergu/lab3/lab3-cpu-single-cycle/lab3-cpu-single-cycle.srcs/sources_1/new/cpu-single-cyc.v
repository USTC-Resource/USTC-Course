`timescale 1ns / 1ps
// single cycle CPU
// 2020 COD Lab3
// ustcpetergu

module cpu_single_cyc
    (
        input clk, 
        input rst,
        input run_in,
        
        output reg RegDst,
        output reg Jump,
        output reg Branch,
        output reg MemRead,
        output reg MemtoReg,
        output reg [2:0]ALUOp,
        output reg MemWrite,
        output reg ALUSrc,
        output reg RegWrite,
        
        output reg [31:0] pc,
        output reg [31:0] newpc,
        output wire [31:0] instruction,

        output wire [31:0]ReadData1,
        output wire [31:0]ReadData2,
        output wire [31:0]ReadData_ram,

        output wire [31:0]ALUResult,
        output wire Zero,


        // debug
        input [7:0]m_rf_addr,
        output wire [31:0]rf_data,
        output wire [31:0]m_data,

        // temporary debug
        output wire [31:0]imm,
        output reg [31:0]alu_b,
        output reg run
    );

    assign imm = {{16{instruction[15]}}, instruction[15:0]};

    rom_instr rom_instr_inst
    (
        .a(pc[9:2]),
        .spo(instruction)
    );
    
    reg [4:0]WriteRegister;
    reg [31:0]WriteData_alu;
    register_file register_file_inst
    (
        .clk(clk),
        .ra0(instruction[25:21]),
        .ra1(instruction[20:16]),
        .ra2(m_rf_addr),
        .wa(WriteRegister),
        .we(RegWrite),
        .wd(WriteData_alu),
        .rd0(ReadData1),
        .rd1(ReadData2),
        .rd2(rf_data)
    );

    ram_data ram_data_inst
    (
        .clk(clk),
        .we(MemWrite),
        .a(ALUResult[7:0]),
        .d(ReadData2),
        .dpra(m_rf_addr),
        .spo(ReadData_ram),
        .dpo(m_data)
    );

    alu_0 alu_0_inst
    (
        .m(ALUOp),
        .a(ReadData1),
        .b(alu_b),
        .y(ALUResult),
        .zf(Zero)
        //.cf(),
        //.of()
    );

    always @(*) begin
        if (RegDst == 1'b1) WriteRegister = instruction[15:11];
        else WriteRegister = instruction[20:16];

        if (ALUSrc == 1'b1) alu_b = imm;
        else alu_b = ReadData2;

        if (MemtoReg == 1'b1) WriteData_alu = ReadData_ram;
        else WriteData_alu = ALUResult;
    end

    always @ (*) begin
        if (run) begin
            RegDst = 0;
            Jump = 0;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
            ALUOp = 3'b000; // default: plus
            case (instruction[31:26])
                6'b000000:
                    case (instruction[5:0])
                        // add--- --rs- --rt- --rd- shamt funct-
                        6'b100000: begin RegDst = 1; RegWrite = 1; end
                        default: ;
                    endcase
                // addi-- --rs- --rt- ----immediate---
                6'b001000: begin ALUSrc = 1; RegWrite = 1; end
                // lw---- --rs- --rt- ----addr--------
                6'b100011: begin ALUSrc = 1; RegWrite = 1; MemRead = 1; MemtoReg = 1; end
                // sw---- --rs- --rt- ----addr--------
                6'b101011: begin ALUSrc = 1; MemWrite = 1; end
                // beq-- --rs- --rt- ----addr--------
                6'b000100: begin Branch = 1; ALUOp = 3'b001; end
                // j---- ----addr------------------
                6'b000010: begin Jump = 1; end
                default: ;
            endcase

            if (Jump == 1'b0) begin
                if ((Branch & Zero) == 1'b0) newpc = pc + 4;
                else newpc = pc + 4 + (imm << 2);
            end
            else newpc = {4'b0000, instruction[25:0], 2'b00};
            //else newpc = {{pc + 4}[31:28], instruction[25:0], 2'b00};
        end
        else begin
            RegDst = 0;
            Jump = 0;
            Branch = 0;
            MemRead = 0;
            MemtoReg = 0;
            MemWrite = 0;
            ALUSrc = 0;
            RegWrite = 0;
            ALUOp = 3'b000;
            newpc = pc;
        end
    end

    always @ (posedge clk) begin
        if (rst) begin
            pc <= 32'b0;
            run <= 0;
        end
        else begin
            pc <= newpc;
            run <= run_in;
        end
    end
endmodule

