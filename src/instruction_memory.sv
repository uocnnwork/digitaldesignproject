module instruction_memory (
    input  logic        clk,
    input  logic [7:0]    A,
    output logic [15:0] RD
);

    import retro_processor_pkg::*;

    logic [15:0] memory [0:255];
    
    initial begin
        memory[0]  = make_instruction(OP_LOADI, 4'd1, 4'd0, 4'd10);
        memory[1]  = make_instruction(OP_LOADI, 4'd2, 4'd0, 4'd5);
        memory[2]  = make_instruction(OP_LOADI, 4'd3, 4'd0, 4'd15);
        memory[3]  = make_instruction(OP_LOADI, 4'd4, 4'd0, 4'd8);
        
        memory[4]  = make_instruction(OP_ADD, 4'd5, 4'd1, 4'd2);
        memory[5]  = make_instruction(OP_SUB, 4'd6, 4'd1, 4'd2);
        memory[6]  = make_instruction(OP_AND, 4'd7, 4'd3, 4'd4);
        memory[7]  = make_instruction(OP_OR, 4'd8, 4'd3, 4'd4);
        
        memory[8]  = make_instruction(OP_SHL, 4'd9, 4'd2, 4'd0);
        memory[9]  = make_instruction(OP_SHR, 4'd10, 4'd3, 4'd0);
        
        memory[10] = make_instruction(OP_STORE, 4'd5, 4'd0, 4'd20);
        memory[11] = make_instruction(OP_STORE, 4'd6, 4'd0, 4'd21);
        memory[12] = make_instruction(OP_STORE, 4'd7, 4'd0, 4'd22);
        memory[13] = make_instruction(OP_STORE, 4'd8, 4'd0, 4'd23);
        
        memory[14] = make_instruction(OP_LOAD, 4'd11, 4'd0, 4'd20);
        memory[15] = make_instruction(OP_LOAD, 4'd12, 4'd0, 4'd21);
        
        memory[16] = make_instruction(OP_MOVE, 4'd13, 4'd11, 4'd0);
        memory[17] = make_instruction(OP_ADDI, 4'd14, 4'd13, 4'd7);
        
        memory[18] = make_instruction(OP_SUB, 4'd0, 4'd14, 4'd2);
        memory[19] = make_instruction(OP_BEQ, 4'd0, 4'd0, 4'd25);
        
        memory[20] = make_instruction(OP_SUB, 4'd0, 4'd14, 4'd1);
        memory[21] = make_instruction(OP_BNE, 4'd0, 4'd0, 4'd30);
        
        memory[22] = make_instruction(OP_LOADI, 4'd15, 4'd0, 4'd99);
        memory[23] = make_instruction(OP_STORE, 4'd15, 4'd0, 4'd50);
        memory[24] = make_instruction(OP_LOADI, 4'd1, 4'd0, 4'd40);
        memory[25] = make_instruction(OP_JUMP, 4'd1, 4'd0, 4'd0);
        
        memory[26] = make_instruction(OP_LOADI, 4'd15, 4'd0, 4'd88);
        memory[27] = make_instruction(OP_STORE, 4'd15, 4'd0, 4'd51);
        memory[28] = make_instruction(OP_LOADI, 4'd1, 4'd0, 4'd40);
        memory[29] = make_instruction(OP_JUMP, 4'd1, 4'd0, 4'd0);
        
        memory[30] = make_instruction(OP_LOADI, 4'd15, 4'd0, 4'd77);
        memory[31] = make_instruction(OP_STORE, 4'd15, 4'd0, 4'd52);
        memory[32] = make_instruction(OP_LOADI, 4'd1, 4'd0, 4'd40);
        memory[33] = make_instruction(OP_JUMP, 4'd1, 4'd0, 4'd0);
        
        memory[40] = make_instruction(OP_LOAD, 4'd1, 4'd0, 4'd50);
        memory[41] = make_instruction(OP_LOAD, 4'd2, 4'd0, 4'd51);
        memory[42] = make_instruction(OP_LOAD, 4'd3, 4'd0, 4'd52);
        
        memory[43] = make_instruction(OP_ADD, 4'd4, 4'd1, 4'd2);
        memory[44] = make_instruction(OP_ADD, 4'd5, 4'd4, 4'd3);
        memory[45] = make_instruction(OP_STORE, 4'd5, 4'd0, 4'd100);
        
        memory[46] = make_instruction(OP_LOADI, 4'd6, 4'd0, 4'd255);
        memory[47] = make_instruction(OP_LOADI, 4'd7, 4'd0, 4'd170);
        memory[48] = make_instruction(OP_AND, 4'd8, 4'd6, 4'd7);
        memory[49] = make_instruction(OP_STORE, 4'd8, 4'd0, 4'd101);
        
        memory[50] = make_instruction(OP_LOADI, 4'd9, 4'd0, 4'd240);
        memory[51] = make_instruction(OP_LOADI, 4'd10, 4'd0, 4'd15);
        memory[52] = make_instruction(OP_OR, 4'd11, 4'd9, 4'd10);
        memory[53] = make_instruction(OP_STORE, 4'd11, 4'd0, 4'd102);
        
        memory[54] = make_instruction(OP_LOADI, 4'd12, 4'd0, 4'd128);
        memory[55] = make_instruction(OP_SHL, 4'd13, 4'd12, 4'd0);
        memory[56] = make_instruction(OP_STORE, 4'd13, 4'd0, 4'd103);
        
        memory[57] = make_instruction(OP_LOADI, 4'd14, 4'd0, 4'd1);
        memory[58] = make_instruction(OP_SHR, 4'd15, 4'd14, 4'd0);
        memory[59] = make_instruction(OP_STORE, 4'd15, 4'd0, 4'd104);
        
        memory[60] = make_instruction(OP_HALT, 4'd0, 4'd0, 4'd0);
        
        for (int i = 34; i < 256; i++) begin
            memory[i] = make_instruction(OP_NOP, 4'b0000, 4'b0000, 4'b0000);
        end
    end
    
    always_comb begin
        RD = memory[A];
    end

endmodule : instruction_memory