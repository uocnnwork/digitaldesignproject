module control_unit (
    input  logic         clk,
    input  logic         reset,
    input  logic [15:0] instruction,
    input  logic [3:0]   alu_flags,
    output logic [2:0]      ALUControl,
    output logic         RegWrite,
    output logic [3:0]    A3,
    output logic         mem_read_enable,
    output logic         MemWrite,
    output logic         PCSrc,
    output logic         ImmSrc,
    output logic         halt_signal
);  

    import retro_processor_pkg::*;

    logic [3:0]   current_opcode;
    logic [3:0] reg_a, reg_b, immediate;
    
    assign current_opcode = get_opcode(instruction);
    assign reg_a = get_reg_a(instruction);
    assign reg_b = get_reg_b(instruction);
    assign immediate = get_immediate(instruction);

    always_comb begin
        ALUControl = ALU_ADD;
        RegWrite = 1'b0;
        A3 = reg_b;
        mem_read_enable = 1'b0;
        MemWrite = 1'b0;
        PCSrc = 1'b0;
        ImmSrc = 1'b0;
        halt_signal = 1'b0;
        
        case (current_opcode)
                OP_NOP: begin
                end
                OP_ADD: begin
                    ALUControl = ALU_ADD;
                    RegWrite = 1'b1;
                    A3 = reg_b;
                end
                OP_SUB: begin
                    ALUControl = ALU_SUB;
                    RegWrite = 1'b1;
                    A3 = reg_b;
                end
                OP_AND: begin
                    ALUControl = ALU_AND;
                    RegWrite = 1'b1;
                    A3 = reg_b;
                end
                OP_OR: begin
                    ALUControl = ALU_OR;
                    RegWrite = 1'b1;
                    A3 = reg_b;
                end
                OP_SHL: begin
                    ALUControl = ALU_SHL;
                    RegWrite = 1'b1;
                    A3 = reg_b;
                end
                OP_SHR: begin
                    ALUControl = ALU_SHR;
                    RegWrite = 1'b1;
                    A3 = reg_b;
                end
                OP_LOAD: begin
                    ALUControl = ALU_PASS_A;
                    mem_read_enable = 1'b1;
                    RegWrite = 1'b1;
                    A3 = reg_b;
                end
                OP_STORE: begin
                    ALUControl = ALU_PASS_A;
                    MemWrite = 1'b1;
                end
                OP_MOVE: begin
                    ALUControl = ALU_PASS_A;
                    RegWrite = 1'b1;
                    A3 = reg_b;
                end
                OP_JUMP: begin
                    ALUControl = ALU_PASS_A;
                    PCSrc = 1'b1;
                end
                OP_BEQ: begin
                    ALUControl = ALU_PASS_A;
                    if (alu_flags[0]) begin
                        PCSrc = 1'b1;
                    end
                end
                OP_BNE: begin
                    ALUControl = ALU_PASS_A;
                    if (!alu_flags[0]) begin
                        PCSrc = 1'b1;
                    end
                end
                OP_ADDI: begin
                    ALUControl = ALU_ADD;
                    RegWrite = 1'b1;
                    A3 = reg_b;
                    ImmSrc = 1'b1;
                end
                OP_LOADI: begin
                    ALUControl = ALU_PASS_B;
                    RegWrite = 1'b1;
                    A3 = reg_a;
                    ImmSrc = 1'b1;
                end
                OP_HALT: begin
                    halt_signal = 1'b1;
                end
                default: begin
                    halt_signal = 1'b1;
                end
            endcase
    end

endmodule : control_unit