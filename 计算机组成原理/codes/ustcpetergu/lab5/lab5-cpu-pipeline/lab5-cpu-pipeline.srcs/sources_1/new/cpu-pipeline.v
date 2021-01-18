`timescale 1ns / 1ps
// pipeline CPU
// 2020 COD Lab5
// ustcpetergu

module cpu_pipeline
    (
        input clk,
        input rst,
        
        output reg [31:0]pc = 0,

        output reg [31:0]npc_ifid = 0,
        output reg [31:0]ir_ifid = 0,

        output reg [31:0]npc_idex = 0,
        output reg [31:0]A_idex = 0,
        output reg [31:0]B_idex = 0,
        output reg [31:0]imm_idex = 0,
        output reg [31:0]ir_idex = 0,
        output reg RegWrite_idex = 0,
        output reg MemtoReg_idex = 0,
        output reg Branch_idex = 0,
        output reg MemRead_idex = 0,
        output reg MemWrite_idex = 0,
        output reg RegDst_idex = 0,
        output reg [2:0]ALUOp_idex = 0,
        output reg ALUSrc_idex = 0,
        output reg Jump_idex = 0,

        output reg [31:0]npc_exmem = 0,
        output reg ZF_exmem = 0,
        output reg [31:0]Y_exmem = 0,
        output reg [31:0]B_exmem = 0,
        output reg [31:0]imm_exmem = 0,
        output reg [31:0]ir_exmem = 0,
        output reg [4:0]WA_exmem = 0,
        output reg RegWrite_exmem = 0,
        output reg MemtoReg_exmem = 0,
        output reg Branch_exmem = 0,
        output reg MemRead_exmem = 0,
        output reg MemWrite_exmem = 0,
        output reg Jump_exmem = 0,

        output reg [31:0]MDR_memwb = 0,
        output reg [31:0]Y_memwb = 0,
        output reg [4:0]WA_memwb = 0,
        output reg [31:0]ir_memwb = 0,
        output reg RegWrite_memwb = 0,
        output reg MemtoReg_memwb = 0,

        output wire PCSrc,

        input [7:0]m_rf_addr,
        output [31:0]rf_data,
        output [31:0]m_data,

        output dummy
    );

    wire [31:0]instruction;
    dist_mem_gen_0 dist_mem_gen_0_inst
    (
        .a(pc[9:2]),
        .spo(instruction)
    );

    wire [31:0]ReadData_ram;
    dist_mem_gen_1 dist_mem_gen_1_inst
    (
        .clk(clk),
        .we(MemWrite_exmem),
        .a(Y_exmem[9:2]),
        .d(B_exmem),
        .dpra(m_rf_addr),
        .spo(ReadData_ram),
        .dpo(m_data)
    );

    reg [31:0]ALUa;
    reg [31:0]ALUb;
    wire [31:0]ALUy;
    wire ALUZero;
    alu_0 alu_0_inst
    (
        .m(ALUOp_idex),
        .a(ALUa),
        .b(ALUb),
        .y(ALUy),
        .zf(ALUZero)
    );

    reg [31:0]WriteData;
    wire [31:0]ReadData1;
    wire [31:0]ReadData2;
    register_file register_file_inst
    (
        .clk(clk),
        .ra0(ir_ifid[25:21]),
        .ra1(ir_ifid[20:16]),
        .ra2(m_rf_addr),
        .wa(WA_memwb),
        .we(RegWrite_memwb),
        .wd(WriteData),
        .rd0(ReadData1),
        .rd1(ReadData2),
        .rd2(rf_data)
    );

    // forwarding unit
    reg exmem2ALUA;
    reg exmem2ALUB;
    reg exmem2DataMem;
    reg memwb2ALUA;
    reg memwb2ALUB;
    reg memwb2DataMem;
    always @ (*) begin
        exmem2ALUA = 0;
        exmem2ALUB = 0;
        exmem2DataMem = 0;
        memwb2ALUA = 0;
        memwb2ALUB = 0;
        memwb2DataMem = 0;
        
        // ADDI + LW
        // ADDI + SW(ex)
        // ADDI + ADDI
        // ADDI + R(A)
        // ADDI + BEQ(A)
        //  exmem(ALUOut) to ALUIn A
        // ADDI + R(B)
        // ADDI + BEQ(B)
        //  exmem(ALUOut) to ALUIn B
        if ((ir_exmem[31:26] == 6'b001000) &
            (ir_idex[31:26] == 6'b100011 | ir_idex[31:26] == 6'b101011 | ir_idex[31:26] == 6'b001000 | ir_idex[31:26] == 6'b000000 | ir_idex[31:26] == 6'b000100) & 
            ir_exmem[20:16] != 5'b0 & ir_exmem[20:16] == ir_idex[25:21]) exmem2ALUA = 1;
        if ((ir_exmem[31:26] == 6'b001000) &
            (ir_idex[31:26] == 6'b000000 | ir_idex[31:26] == 6'b000100) & 
            ir_exmem[20:16] != 5'b0 & ir_exmem[20:16] == ir_idex[20:16]) exmem2ALUB = 1;

        // R + LW
        // R + SW(ex)
        // R + ADDI
        // R + R(A)
        // R + BEQ(A)
        //  exmem(ALUOut) to ALUIn A
        // R + R(B)
        // R + BEQ(B)
        //  exmem(ALUOut) to ALUIn B
        if ((ir_exmem[31:26] == 6'b000000) &
            (ir_idex[31:26] == 6'b100011 | ir_idex[31:26] == 6'b101011 | ir_idex[31:26] == 6'b001000 | ir_idex[31:26] == 6'b000000 | ir_idex[31:26] == 6'b000100) & 
            ir_exmem[15:11] != 5'b0 & ir_exmem[15:11] == ir_idex[25:21]) exmem2ALUA = 1;
        if ((ir_exmem[31:26] == 6'b000000) &
            (ir_idex[31:26] == 6'b000000 | ir_idex[31:26] == 6'b000100) & 
            ir_exmem[15:11] != 5'b0 & ir_exmem[15:11] == ir_idex[20:16]) exmem2ALUB = 1;

        // LW + * + LW
        // LW + * + SW(wb)
        // LW + * + ADDI
        // LW + * + R(A)
        // LW + * + BEQ(A)
        // ADDI + * + LW
        // ADDI + * + SW(ex)
        // ADDI + * + ADDI
        // ADDI + * + R(A)
        // ADDI + * + BEQ(A)
        //  memwb(ALUOut or MDR) to ALUIn A
        // LW + * + R(B)
        // LW + * + BEQ(B)
        // ADDI + * + R(B)
        // ADDI + * + BEQ(B)
        //  memwb(ALUOut or MDR) to ALUIn B
        if ((ir_memwb[31:26] == 6'b100011 | ir_memwb[31:26] == 6'b001000 | ir_memwb[31:26] == 6'b000000) &
            (ir_idex[31:26] == 6'b100011 | ir_idex[31:26] == 6'b101011 | ir_idex[31:26] == 6'b001000 | ir_idex[31:26] == 6'b000000 | ir_idex[31:26] == 6'b000100) & 
            ir_memwb[20:16] != 5'b0 & ir_memwb[20:16] == ir_idex[25:21]) memwb2ALUA = 1;
        if ((ir_memwb[31:26] == 6'b100011 | ir_memwb[31:26] == 6'b001000 | ir_memwb[31:26] == 6'b000000) &
            (ir_idex[31:26] == 6'b000000 | ir_idex[31:26] == 6'b000100) & 
            ir_memwb[20:16] != 5'b0 & ir_memwb[20:16] == ir_idex[20:16]) memwb2ALUB = 1;
        // R + * + LW
        // R + * + SW(ex)
        // R + * + ADDI
        // R + * + R(A)
        // R + * + BEQ(A)
        //  memwb(ALUOut) to ALUIn A
        // R + * + R(B)
        // R + * + BEQ(B)
        //  memwb(ALUOut) to ALUIn B
        if ((ir_memwb[31:26] == 6'b000000) &
            (ir_idex[31:26] == 6'b100011 | ir_idex[31:26] == 6'b101011 | ir_idex[31:26] == 6'b001000 | ir_idex[31:26] == 6'b000000 | ir_idex[31:26] == 6'b000100) & 
            ir_memwb[15:11] != 5'b0 & ir_memwb[15:11] == ir_idex[25:21]) memwb2ALUA = 1;
        if ((ir_memwb[31:26] == 6'b000000) &
            (ir_idex[31:26] == 6'b000000 | ir_idex[31:26] == 6'b000100) & 
            ir_memwb[15:11] != 5'b0 & ir_memwb[15:11] == ir_idex[20:16]) memwb2ALUB = 1;
        
        // R + SW(wb)
        // exmem(ALUOut) to DataMemory(B_exmem)
        // R + * + SW(wb)
        // memwb(ALUOut) to DataMemory(B_exmem)
        // LW + SW(wb)
        // memwb(MDR) to DataMemory(B_exmem)
        if ((ir_exmem[31:26] == 6'b000000) &
            (ir_idex[31:26] == 6'b101011) &
            ir_exmem[15:11] != 5'b0 & ir_exmem[15:11] == ir_idex[20:16]) exmem2DataMem = 1;
        if ((ir_memwb[31:26] == 6'b000000) &
            (ir_idex[31:26] == 6'b101011) &
            ir_memwb[15:11] != 5'b0 & ir_memwb[15:11] == ir_idex[20:16]) memwb2DataMem = 1;
        if ((ir_memwb[31:26] == 6'b100011) &
            (ir_idex[31:26] == 6'b101011) &
            ir_memwb[20:16] != 5'b0 & ir_memwb[20:16] == ir_idex[20:16]) exmem2DataMem = 1;

    end

    // hazard detection unit
    reg nPCWrite;
    reg nIFIDWrite;
    reg nControl;
    always @ (*) begin
        // LW + R(A, B)
        // LW + LW
        // LW + ADDI
        // LW + SW(ex)
        // LW + BEQ(A, B)
        // stall
        if (ir_idex[31:26] == 6'b100011 & (
            (ir_idex[20:16] != 5'b0 & ir_idex[20:16] == ir_ifid[25:21] & (ir_ifid[31:26] == 6'b000000 | ir_ifid[31:26] == 6'b100011 | ir_ifid[31:26] == 6'b001000 | ir_ifid[31:26] == 6'b101011 | ir_ifid[31:26] == 6'b000100)) | 
            (ir_idex[20:16] != 5'b0 & ir_idex[20:16] == ir_ifid[20:16] & (ir_ifid[31:26] == 6'b000000 | ir_ifid[31:26] == 6'b000100))
        )) begin
            nPCWrite = 1;
            nIFIDWrite = 1;
            nControl = 1;
        end
        else begin
            nPCWrite = 0;
            nIFIDWrite = 0;
            nControl = 0;
        end
    end

    // control unit
    assign PCSrc = ZF_exmem & Branch_exmem;
    assign Flush = Jump_exmem | PCSrc;
    reg RegWrite;
    reg MemtoReg;
    reg Branch;
    reg MemRead;
    reg MemWrite;
    reg RegDst;
    reg ALUOp;
    reg ALUSrc;
    reg Jump;
    always @ (*) begin
        RegWrite = 0;
        MemtoReg = 0;
        Branch = 0;
        MemRead = 0;
        MemWrite = 0;
        RegDst = 0;
        ALUOp = 3'b0;
        ALUSrc = 0;
        Jump = 0;
        case (ir_ifid[31:26])
            6'b000000:
                case (ir_ifid[5:0])
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
    end
    always @ (posedge clk) begin
        if (rst) begin
            RegWrite_idex <= 0;
            MemtoReg_idex <= 0;
            Branch_idex <= 0;
            MemRead_idex <= 0;
            MemWrite_idex <= 0;
            RegDst_idex <= 0;
            ALUOp_idex <= 0;
            ALUSrc_idex <= 0;
            Jump_idex <= 0;

            RegWrite_exmem <= 0;
            MemtoReg_exmem <= 0;
            Branch_exmem <= 0;
            MemRead_exmem <= 0;
            MemWrite_exmem <= 0;
            Jump_exmem <= 0;

            RegWrite_memwb <= 0;
            MemtoReg_memwb <= 0;
        end
        else begin
            // control -- idex
            if (nControl == 0 & Flush== 0) begin
                RegWrite_idex <= RegWrite;
                MemtoReg_idex <= MemtoReg;
                Branch_idex <= Branch;
                MemRead_idex <= MemRead;
                MemWrite_idex <= MemWrite;
                RegDst_idex <= RegDst;
                ALUOp_idex <= ALUOp;
                ALUSrc_idex <= ALUSrc;
                Jump_idex <= Jump;
            end
            else begin
                RegWrite_idex <= 0;
                MemtoReg_idex <= 0;
                Branch_idex <= 0;
                MemRead_idex <= 0;
                MemWrite_idex <= 0;
                RegDst_idex <= 0;
                ALUOp_idex <= 3'b0;
                ALUSrc_idex <= 0;
                Jump_idex <= 0;
            end

            // control -- exmem
            // this flush is actually unnecessary
            if (Flush) begin
                RegWrite_exmem <= 0;
                MemtoReg_exmem <= 0;
                Branch_exmem <= 0;
                MemRead_exmem <= 0;
                MemWrite_exmem <= 0;
                Jump_exmem <= 0;
            end
            else begin
                RegWrite_exmem <= RegWrite_idex;
                MemtoReg_exmem <= MemtoReg_idex;
                Branch_exmem <= Branch_idex;
                MemRead_exmem <= MemRead_idex;
                MemWrite_exmem <= MemWrite_idex;
                Jump_exmem <= Jump_idex;
            end

            // control -- memwb
            RegWrite_memwb <= RegWrite_exmem;
            MemtoReg_memwb <= MemtoReg_exmem;
        end
    end

    always @ (*) begin
        // with forwarding
        if (exmem2ALUA) ALUa = Y_exmem;
        else if (memwb2ALUA) ALUa = WriteData;
        else ALUa = A_idex;
    end
    always @ (*) begin
        // with forwarding
        if (exmem2ALUB) ALUb = Y_exmem;
        else if (memwb2ALUB) ALUb = WriteData;
        else if (ALUSrc_idex) ALUb = imm_idex;
        else ALUb = B_idex;
    end
    always @ (*) begin
        if (MemtoReg_memwb) WriteData = MDR_memwb;
        else WriteData = Y_memwb;
    end
    always @ (posedge clk) begin
        if (rst) begin
            pc <= 0;

            npc_ifid <= 0;
            ir_ifid <= 0;

            npc_idex <= 0;
            A_idex <= 0;
            B_idex <= 0;
            imm_idex <= 0;
            ir_idex <= 0;

            npc_exmem <= 0;
            ZF_exmem <= 0;
            Y_exmem <= 0;
            B_exmem <= 0;
            imm_exmem <= 0;
            ir_exmem <= 0;
            WA_exmem <= 0;

            MDR_memwb <= 0;
            Y_memwb <= 0;
            WA_memwb <= 0;
            ir_memwb <= 0;
        end
        else begin
            // pc
            // with interlock
            if (nPCWrite == 0) begin
                if (Jump_exmem) pc <= {4'b0000, ir_exmem[25:0], 2'b00};
                else if (PCSrc) pc <= npc_exmem;
                else pc <= pc + 4;
            end

            // data -- ifid
            // with interlock
            if (Flush) begin
                npc_ifid <= 0;
                ir_ifid <= 0;
            end
            else if (nIFIDWrite == 0) begin
                npc_ifid <= pc + 4;
                ir_ifid <= instruction;
            end

            // data -- idex
            if (Flush) begin
                npc_idex <= 0;
                A_idex <= 0;
                B_idex <= 0;
                imm_idex <= 0;
                ir_ifid <= 0;
            end
            else begin
                npc_idex <= npc_ifid;
                A_idex <= ReadData1;
                B_idex <= ReadData2;
                imm_idex <= {{16{ir_ifid[15]}}, ir_ifid[15:0]};
                ir_idex <= ir_ifid;
            end

            // data -- exmem
            // this flush is actually unnecessary
            if (Flush) begin
                npc_exmem <= 0;
                ZF_exmem <= 0;
                Y_exmem <= 0;
                imm_idex <= 0;
                WA_exmem <= 0;
                B_exmem <= 0;
            end
            else begin
                npc_exmem <= npc_idex + (imm_idex << 2);
                ZF_exmem <= ALUZero;
                Y_exmem <= ALUy;
                imm_exmem <= imm_idex;
                if (RegDst_idex) WA_exmem <= ir_idex[15:11];
                else WA_exmem <= ir_idex[20:16];
                ir_exmem <= ir_idex;
                // with forwarding
                if (exmem2DataMem) B_exmem <= Y_exmem;
                else B_exmem <= B_idex;
            end

            // data -- memwb
            MDR_memwb <= ReadData_ram;
            Y_memwb <= Y_exmem;
            WA_memwb <= WA_exmem;
            ir_memwb <= ir_exmem;
        end
    end
endmodule

