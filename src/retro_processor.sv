module retro_processor (
    input  logic clk,
    input  logic reset,
    output logic [7:0]    debug_pc,
    output logic [15:0] debug_instruction,
    output logic [7:0]       debug_reg_data_a,
    output logic [7:0]       debug_reg_data_b,
    output logic [3:0]  debug_alu_flags,
    output logic        debug_halted
);

    import retro_processor_pkg::*;

    logic [7:0] PC;
    logic PCSrc;
    logic [7:0] PCPlus4;
    logic [15:0] Instr;
    logic [2:0] ALUControl;
    logic RegWrite;
    logic [3:0] A3;
    logic mem_read_enable;
    logic MemWrite;
    logic ImmSrc;
    logic halt_signal;
    logic [3:0] RA1, RA2;
    logic [7:0] RD1, RD2;
    logic [7:0] WD3;
    logic [7:0] SrcA, SrcB;
    logic [7:0] ALUResult;
    logic [3:0] ALUFlags;
    logic [7:0] A;
    logic [7:0] WD;
    logic [7:0] RD;
    logic processor_halted;
    
    logic [3:0] current_opcode;
    logic [3:0] inst_reg_a, inst_reg_b, ExtImm;
    
    assign current_opcode = get_opcode(Instr);
    assign inst_reg_a = get_reg_a(Instr);
    assign inst_reg_b = get_reg_b(Instr);
    assign ExtImm = get_immediate(Instr);
    
    logic halt_pending;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            processor_halted <= 1'b0;
            halt_pending <= 1'b0;
        end else if (halt_signal) begin
            halt_pending <= 1'b1;
        end else if (halt_pending) begin
            processor_halted <= 1'b1;
            halt_pending <= 1'b0;
        end
    end
    
    always_comb begin
        RA1 = inst_reg_a;
        case (current_opcode)
            OP_STORE: begin
                RA2 = inst_reg_b;
            end
            default: begin
                RA2 = ExtImm;
            end
        endcase
    end
    
    always_comb begin
        SrcA = RD1;
        if (ImmSrc) begin
            SrcB = {4'b0000, ExtImm};
        end else begin
            SrcB = RD2;
        end
    end
    
    always_comb begin
        case (current_opcode)
            OP_LOAD: begin
                WD3 = RD;
            end
            default: begin
                WD3 = ALUResult;
            end
        endcase
    end
    
    always_comb begin
        case (current_opcode)
            OP_LOAD, OP_STORE: begin
                A = RD1;
                WD = RD2;
            end
            default: begin
                A = 8'h00;
                WD = 8'h00;
            end
        endcase
    end
    
    always_comb begin
        case (current_opcode)
            OP_JUMP: begin
                PCPlus4 = {4'b0000, ExtImm};  // Sử dụng immediate cho JUMP
            end
            OP_BEQ, OP_BNE: begin
                PCPlus4 = RD1;  // BEQ/BNE vẫn dùng thanh ghi
            end
            default: begin
                PCPlus4 = 8'h00;
            end
        endcase
    end
    
    assign debug_pc = PC;
    assign debug_instruction = Instr;
    assign debug_reg_data_a = RD1;
    assign debug_reg_data_b = RD2;
    assign debug_alu_flags = ALUFlags;
    assign debug_halted = processor_halted;
    
    program_counter pc_inst (
        .clk(clk),
        .reset(reset),
        .jump_enable(PCSrc & ~processor_halted),
        .jump_address(PCPlus4),
        .halt(processor_halted),
        .PC(PC)
    );
    
    instruction_memory imem_inst (
        .clk(clk),
        .A(PC),
        .RD(Instr)
    );
    
    control_unit ctrl_inst (
        .clk(clk),
        .reset(reset),
        .instruction(Instr),
        .alu_flags(ALUFlags),
        .ALUControl(ALUControl),
        .RegWrite(RegWrite),
        .A3(A3),
        .mem_read_enable(mem_read_enable),
        .MemWrite(MemWrite),
        .PCSrc(PCSrc),
        .ImmSrc(ImmSrc),
        .halt_signal(halt_signal)
    );
    
    register_file regfile_inst (
        .clk(clk),
        .reset(reset),
        .RA1(RA1),
        .RA2(RA2),
        .RD1(RD1),
        .RD2(RD2),
        .A3(A3),
        .WD3(WD3),
        .WE3(RegWrite & ~processor_halted)
    );
    
    alu alu_inst (
        .clk(clk),
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .ALUFlags(ALUFlags)
    );
    
    data_memory dmem_inst (
        .clk(clk),
        .reset(reset),
        .A(A),
        .WD(WD),
        .read_enable(mem_read_enable & ~processor_halted),
        .WE(MemWrite & ~processor_halted),
        .RD(RD)
    );

endmodule : retro_processor