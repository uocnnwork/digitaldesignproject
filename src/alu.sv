module alu (
    input  logic     clk,
    input  logic [7:0]    SrcA,
    input  logic [7:0]    SrcB,
    input  logic [2:0]  ALUControl,
    output logic [7:0]      ALUResult,
    output logic [3:0] ALUFlags
);

    import retro_processor_pkg::*;

    logic [8:0] extended_result;
    logic [7:0] temp_result;
    logic       temp_zero;
    logic       temp_carry;
    logic       temp_negative;
    logic       temp_overflow;

    always_comb begin
        extended_result = 9'b0;
        temp_result = 8'b0;
        temp_carry = 1'b0;
        temp_overflow = 1'b0;
        
        case (ALUControl)
            ALU_ADD: begin
                extended_result = {1'b0, SrcA} + {1'b0, SrcB};
                temp_result = extended_result[7:0];
                temp_carry = extended_result[8];
                temp_overflow = (SrcA[7] == SrcB[7]) && (temp_result[7] != SrcA[7]);
            end
            
            ALU_SUB: begin
                extended_result = {1'b0, SrcA} - {1'b0, SrcB};
                temp_result = extended_result[7:0];
                temp_carry = extended_result[8];
                temp_overflow = (SrcA[7] != SrcB[7]) && (temp_result[7] != SrcA[7]);
            end
            
            ALU_AND: begin
                temp_result = SrcA & SrcB;
                temp_carry = 1'b0;
                temp_overflow = 1'b0;
            end
            
            ALU_OR: begin
                temp_result = SrcA | SrcB;
                temp_carry = 1'b0;
                temp_overflow = 1'b0;
            end
            
            ALU_SHL: begin
                extended_result = {SrcA, 1'b0};
                temp_result = extended_result[7:0];
                temp_carry = extended_result[8];
                temp_overflow = 1'b0;
            end
            
            ALU_SHR: begin
                temp_result = {1'b0, SrcA[7:1]};
                temp_carry = SrcA[0];
                temp_overflow = 1'b0;
            end
            
            ALU_PASS_A: begin
                temp_result = SrcA;
                temp_carry = 1'b0;
                temp_overflow = 1'b0;
            end
            
            ALU_PASS_B: begin
                temp_result = SrcB;
                temp_carry = 1'b0;
                temp_overflow = 1'b0;
            end
            
            default: begin
                temp_result = 8'b0;
                temp_carry = 1'b0;
                temp_overflow = 1'b0;
            end
        endcase
        
        temp_zero = (temp_result == 8'b0);
        temp_negative = temp_result[7];
    end

    assign ALUResult = temp_result;
    assign ALUFlags = {temp_overflow, temp_negative, temp_carry, temp_zero};

endmodule : alu