`timescale 1ns / 1ps
// multiple cycle CPU
// 2020 COD Lab4
// ustcpetergu

module cpu_multi_cycle
    (
        input clk,
        input rst,

        output reg [31:0]instruction = 32'hffffffff,
        output reg [31:0]pc = 32'hffffffff,

        output reg [31:0]mdr = 32'hffffffff,

        output reg [31:0]ALUOut = 32'hffffffff,
        output reg [31:0]A = 32'hffffffff,
        output reg [31:0]B = 32'hffffffff,

        output reg PCWriteCond,
        output reg PCWrite,
        output reg IorD,
        output reg MemRead,
        output reg MemWrite,
        output reg MemtoReg,
        output reg IRWrite,
        output reg [1:0]PCSource,
        output reg [2:0]ALUm,
        output reg ALUSrcA,
        output reg [1:0]ALUSrcB,
        output reg RegWrite,
        output reg RegDst,

        output wire ALUZero,

        output wire PCwe,

        input [8:0]m_rf_addr,
        output wire [31:0]rf_data,
        output wire [31:0]m_data,

        // debug
        output wire [31:0]ReadData1,
        output wire [31:0]ReadData2,
        output reg [31:0]newpc,
        output reg [3:0]phase = IF,

        output reg dummy
    );

    wire [31:0]imm = {{16{instruction[15]}}, instruction[15:0]};
    assign PCwe = (ALUZero & PCWriteCond) | PCWrite;

    //reg [31:0]newpc;

    reg [4:0]WriteRegister;
    reg [31:0]WriteData;
    //wire [31:0]ReadData1;
    //wire [31:0]ReadData2;
    register_file register_file_inst
    (
        .clk(clk),
        .ra0(instruction[25:21]),
        .ra1(instruction[20:16]),
        .ra2(m_rf_addr),
        .wa(WriteRegister),
        .we(RegWrite),
        .wd(WriteData),
        .rd0(ReadData1),
        .rd1(ReadData2),
        .rd2(rf_data)
    );

    reg [31:0]mem_addr;
    wire [31:0]MemData;
    ram_0 ram_inst
    (
        .clk(clk),
        .we(MemWrite),
        .a(mem_addr[10:2]),
        .d(B),
        .dpra(m_rf_addr),
        .spo(MemData),
        .dpo(m_data)
    );

    reg [31:0]ALUIn1;
    reg [31:0]ALUIn2;
    wire [31:0]ALUResult;
    alu_0 alu_0_inst
    (
        .m(ALUm),
        .a(ALUIn1),
        .b(ALUIn2),
        .y(ALUResult),
        .zf(ALUZero)
        //.cf(),
        //.of()
    );
    
    // control unit FSM
    // input: instruction[31:26], output: control signals
    wire [5:0]Op = instruction[31:26];
    localparam IF = 0;
    localparam ID_RF = 1;
    localparam MEM_ADDR_CALC = 2;
    localparam MEM_ACCESS_LW = 3;
    localparam WB = 4; 
    localparam MEM_ACCESS_SW = 5;
    localparam R_EX = 6;
    localparam R_END = 7;
    localparam BEQ_END = 8;
    localparam J_END = 9;
    localparam ADDI_END = 10;
    localparam BAD = 11;
    localparam OP_ADD = 6'b000000;
    localparam OP_ADDI = 6'b001000;
    localparam OP_LW = 6'b100011;
    localparam OP_SW = 6'b101011;
    localparam OP_BEQ = 6'b000100;
    localparam OP_J = 6'b000010;
    //reg [3:0]phase = IF;
    always @ (*) begin
        PCWriteCond = 0;
        PCWrite = 0;
        IorD = 0;
        MemRead = 0;
        MemWrite = 0;
        MemtoReg = 0;
        IRWrite = 0;
        PCSource = 2'b00;
        ALUm = 3'b000;
        ALUSrcA = 0;
        ALUSrcB = 0;
        RegWrite = 0;
        RegDst = 0;
        case (phase)
            IF: begin MemRead = 1; ALUSrcB = 2'b01; IRWrite = 1; PCWrite = 1; end
            ID_RF: ALUSrcB = 2'b11;
            MEM_ADDR_CALC: begin ALUSrcA = 1; ALUSrcB = 2'b10; end
            MEM_ACCESS_LW: begin MemRead = 1; IorD = 1; end
            ADDI_END: begin RegWrite = 1; end
            WB: begin RegWrite = 1; MemtoReg = 1; end
            MEM_ACCESS_SW: begin IorD = 1; MemWrite = 1; end
            R_EX: ALUSrcA = 1;
            R_END: begin RegDst = 1; RegWrite = 1; end
            BEQ_END: begin ALUSrcA = 1; ALUm = 3'b001; PCWriteCond = 1; PCSource = 2'b01; end
            J_END: begin PCWrite = 1; PCSource = 2'b10; end
            default: ;
        endcase
    end
    always @ (posedge clk or posedge rst) begin
        if (rst) begin
            phase <= IF;
        end
        else begin
            case(phase)
                IF: phase <= ID_RF;
                ID_RF: 
                    case(Op)
                        OP_LW: phase <= MEM_ADDR_CALC;
                        OP_SW: phase <= MEM_ADDR_CALC;
                        OP_ADDI: phase <= MEM_ADDR_CALC;
                        OP_ADD: phase <= R_EX;
                        OP_BEQ: phase <= BEQ_END;
                        OP_J: phase <= J_END;
                        default: phase <= BAD;
                    endcase
                MEM_ADDR_CALC:
                    case (Op)
                        OP_LW: phase <= MEM_ACCESS_LW;
                        OP_SW: phase <= MEM_ACCESS_SW;
                        OP_ADDI: phase <= ADDI_END;
                        default: phase <= BAD;
                    endcase
                MEM_ACCESS_LW: phase <= WB;
                WB: phase <= IF;
                MEM_ACCESS_SW: phase <= IF;
                ADDI_END: phase <= IF;
                R_EX: phase <= R_END;
                R_END: phase <= IF;
                BEQ_END: phase <= IF;
                J_END: phase <= IF;
                default: phase <= BAD;
            endcase
        end
    end

    always @ (*) begin
        if (IorD) mem_addr = ALUOut; else mem_addr = pc;
        if (ALUSrcA) ALUIn1 = A; else ALUIn1 = pc;
        if (RegDst) WriteRegister = instruction[15:11]; 
            else WriteRegister = instruction[20:16];
        if (MemtoReg) WriteData = mdr;
            else WriteData = ALUOut;
        case (ALUSrcB)
            0: ALUIn2 = B;
            1: ALUIn2 = 4;
            2: ALUIn2 = imm;
            3: ALUIn2 = imm << 2;
        endcase
        case (PCSource)
            0: newpc = ALUResult;
            1: newpc = ALUOut;
            2: newpc = {pc[31:28], instruction[25:0], 2'b0};
            default: newpc = 32'hffffffff;
        endcase
    end
    always @ (posedge clk) begin
        if (rst) begin
            pc <= 32'b0;
        end
        else begin
            A <= ReadData1;
            B <= ReadData2;
            ALUOut <= ALUResult;
            mdr <= MemData;
            if (PCwe) pc <= newpc;
            if (IRWrite) instruction <= MemData;
        end
    end
endmodule

