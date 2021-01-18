`timescale 1ns / 1ps
// pipeline cycle CPU -- DBU
// 2020 COD Lab5
// ustcpetergu

module edgefetcher
    (
        input clk, rst,
        input y,
        output p
    );
    reg [1:0]state = 0;
    reg [1:0]next_state = 0; 
    assign p = (state == 1);
    always @ (posedge clk) begin
        if (rst) begin
            state <= 0;
            next_state <= 0;
        end
        else state <= next_state;
    end
    always @ (*) begin
        next_state = state;
        case (state)
            0: if (y) next_state = 1;
            1: if (y) next_state = 2; else next_state = 0;
            2: if (y) next_state = 2; else next_state = 0;
            default: next_state = 0;
        endcase
    end
endmodule

module pipeline_dbu
    (
        input clk,
        input rst,
        input succ, 
        input step,
        input [2:0]sel,
        input [1:0]sel2,
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
    reg step_real_old = 0;
    wire inc_real;
    wire dec_real;

    edgefetcher edgefetcher_inst
    (
        .clk(clk),
        .rst(rst),
        .y(step),
        .p(step_real)
    );
    edgefetcher edgefetcher_inst_1
    (
        .clk(clk),
        .rst(rst),
        .y(inc),
        .p(inc_real)
    );
    edgefetcher edgefetcher_inst_2
    (
        .clk(clk),
        .rst(rst),
        .y(dec),
        .p(dec_real)
    );

    reg dclk = 0;
    reg [7:0]m_rf_addr = 0;
    wire [31:0]m_data;
    wire [31:0]rf_data;

    wire [31:0]pc;

    wire [31:0]npc_ifid;
    wire [31:0]ir_ifid;

    wire [31:0]npc_idex;
    wire [31:0]ir_idex;
    wire [31:0]A_idex;
    wire [31:0]B_idex;
    wire RegWrite_idex;
    wire MemtoReg_idex;
    wire Branch_idex;
    wire MemRead_idex;
    wire RegDst_idex;
    wire [2:0]ALUOp_idex;
    wire ALUSrc_idex;
    wire Jump_idex;

    wire [31:0]npc_exmem;
    wire [31:0]ir_exmem;
    wire [31:0]Y_exmem;
    wire [31:0]imm_exmem;
    wire RegWrite_exmem;
    wire MemtoReg_exmem;
    wire Branch_exmem;
    wire MemWrite_exmem;
    wire MemRead_exmem;
    wire MemWrite_idex;
    wire Jump_exmem;

    wire [31:0]MDR_memwb;
    wire [31:0]ir_memwb;
    wire [31:0]Y_memwb;
    wire [31:0]WA_memwb;
    wire RegWrite_memwb;
    wire MemtoReg_memwb;

    cpu_pipeline cpu_pipeline_inst
    (
        .clk(dclk),
        //.clk(clk),
        .rst(rst),

        .pc(pc),

        .npc_ifid(npc_ifid),
        .ir_ifid(ir_ifid),

        .npc_idex(npc_idex),
        .ir_idex(ir_idex),
        .A_idex(A_idex),
        .B_idex(B_idex),
        .RegWrite_idex(RegWrite_idex),
        .MemtoReg_idex(MemtoReg_idex),
        .Branch_idex(Branch_idex),
        .MemRead_idex(MemRead_idex),
        .RegDst_idex(RegDst_idex),
        .ALUOp_idex(ALUOp_idex),
        .ALUSrc_idex(ALUSrc_idex),
        .Jump_idex(Jump_idex),

        .npc_exmem(npc_exmem),
        .ir_exmem(ir_exmem),
        .Y_exmem(Y_exmem),
        .imm_exmem(imm_exmem),
        .RegWrite_exmem(RegWrite_exmem),
        .MemtoReg_exmem(MemtoReg_exmem),
        .Branch_exmem(Branch_exmem),
        .MemWrite_exmem(MemWrite_exmem),
        .MemRead_exmem(MemRead_exmem),
        .MemWrite_idex(MemWrite_idex),
        .Jump_exmem(Jump_exmem),

        .MDR_memwb(MDR_memwb),
        .ir_memwb(ir_memwb),
        .Y_memwb(Y_memwb),
        .WA_memwb(WA_memwb),
        .RegWrite_memwb(RegWrite_memwb),
        .MemtoReg_memwb(MemtoReg_memwb),

        .m_rf_addr(m_rf_addr),
        .rf_data(rf_data),
        .m_data(m_data)
    );
    //always @ (posedge clk)
        //dclk = ~dclk;

    always @ (posedge clk) begin
        if (rst) begin
            m_rf_addr <= 0;
            //dclk <= 0;
            dclk <= ~dclk;
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
            else begin
                case (sel)
                    3: led <= {RegWrite_idex, MemtoReg_idex, Branch_idex, MemRead_idex, MemWrite_idex, RegDst_idex, ALUOp_idex, ALUSrc_idex, Jump_idex, 5'b0};
                    4: led <= {RegWrite_exmem, MemtoReg_exmem, Branch_exmem, MemRead_exmem, MemWrite_exmem, 0, 3'b000, 0, Jump_exmem, 5'b0};
                    5: led <= {RegWrite_memwb, MemtoReg_memwb, 0, 0, 0, 0, 3'b000, 0, 0, 5'b0};
                    default: led <= 16'hFF;
                endcase
            end

            case (sel)
                0: begin 
                    if (m_rf == 1) seg_data <= m_data; else seg_data <= rf_data;
                end
                1: seg_data <= pc;
                2: case (sel2)
                    0: seg_data <= npc_ifid;
                    1: seg_data <= ir_ifid;
                    default: seg_data <= 0;
                endcase
                3: case (sel2)
                    0: seg_data <= npc_idex;
                    1: seg_data <= ir_idex;
                    2: seg_data <= A_idex;
                    3: seg_data <= B_idex;
                endcase
                4: case (sel2)
                    0: seg_data <= npc_exmem;
                    1: seg_data <= ir_exmem;
                    2: seg_data <= Y_exmem;
                    3: seg_data <= imm_exmem;
                endcase
                5: case (sel2)
                    0: seg_data <= MDR_memwb;
                    1: seg_data <= ir_memwb;
                    2: seg_data <= Y_memwb;
                    3: seg_data <= WA_memwb;
                endcase
                default: seg_data <= 32'b0;
            endcase
        end
    end

endmodule
