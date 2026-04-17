package retro_processor_pkg;

    typedef logic [7:0]  data_t;
    typedef logic [15:0] instruction_t;
    typedef logic [7:0]  address_t;
    typedef logic [3:0]  reg_addr_t;
    typedef logic [2:0]  alu_op_t;
    typedef logic [3:0]  opcode_t;

    typedef struct packed {
        opcode_t   opcode;
        reg_addr_t reg_a;
        reg_addr_t reg_b;
        reg_addr_t immediate;
    } instruction_format_t;

    typedef struct packed {
        logic zero;
        logic carry;
        logic negative;
        logic overflow;
    } alu_flags_t;

    typedef struct packed {
        alu_op_t ALUControl;
        logic    RegWrite;
        reg_addr_t A3;
        logic    mem_read_enable;
        logic    MemWrite;
        logic    PCSrc;
        logic    ImmSrc;
    } control_signals_t;

    typedef struct {
        data_t registers[16];
        data_t memory[256];
        address_t program_counter;
        alu_flags_t flags;
        logic halted;
    } processor_state_t;

    parameter opcode_t OP_NOP   = 4'b0000;
    parameter opcode_t OP_ADD   = 4'b0001;
    parameter opcode_t OP_SUB   = 4'b0010;
    parameter opcode_t OP_AND   = 4'b0011;
    parameter opcode_t OP_OR    = 4'b0100;
    parameter opcode_t OP_SHL   = 4'b0101;
    parameter opcode_t OP_SHR   = 4'b0110;
    parameter opcode_t OP_LOAD  = 4'b0111;
    parameter opcode_t OP_STORE = 4'b1000;
    parameter opcode_t OP_MOVE  = 4'b1001;
    parameter opcode_t OP_JUMP  = 4'b1010;
    parameter opcode_t OP_BEQ   = 4'b1011;
    parameter opcode_t OP_BNE   = 4'b1100;
    parameter opcode_t OP_ADDI  = 4'b1101;
    parameter opcode_t OP_LOADI = 4'b1110;
    parameter opcode_t OP_HALT  = 4'b1111;

    parameter alu_op_t ALU_ADD    = 3'b000;
    parameter alu_op_t ALU_SUB    = 3'b001;
    parameter alu_op_t ALU_AND    = 3'b010;
    parameter alu_op_t ALU_OR     = 3'b011;
    parameter alu_op_t ALU_SHL    = 3'b100;
    parameter alu_op_t ALU_SHR    = 3'b101;
    parameter alu_op_t ALU_PASS_A = 3'b110;
    parameter alu_op_t ALU_PASS_B = 3'b111;

    parameter reg_addr_t REG_ZERO  = 4'd0;
    parameter reg_addr_t REG_SP    = 4'd8;
    parameter reg_addr_t REG_FP    = 4'd9;
    parameter reg_addr_t REG_RA    = 4'd10;
    parameter reg_addr_t REG_ACC   = 4'd15;

    parameter address_t MEM_DATA_START = 8'h00;
    parameter address_t MEM_DATA_END   = 8'h7F;
    parameter address_t MEM_IO_START   = 8'h80;
    parameter address_t MEM_IO_END     = 8'hFF;

    parameter int INSTRUCTION_MEMORY_SIZE = 256;
    parameter int DATA_MEMORY_SIZE = 256;
    parameter int REGISTER_COUNT = 16;

    function automatic opcode_t get_opcode(instruction_t inst);
        return inst[15:12];
    endfunction

    function automatic reg_addr_t get_reg_a(instruction_t inst);
        return inst[11:8];
    endfunction

    function automatic reg_addr_t get_reg_b(instruction_t inst);
        return inst[7:4];
    endfunction

    function automatic reg_addr_t get_immediate(instruction_t inst);
        return inst[3:0];
    endfunction

    function automatic instruction_t make_instruction(
        opcode_t opcode,
        reg_addr_t reg_a,
        reg_addr_t reg_b,
        reg_addr_t immediate
    );
        return {opcode, reg_a, reg_b, immediate};
    endfunction

endpackage : retro_processor_pkg