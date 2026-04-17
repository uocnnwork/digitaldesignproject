module control_unit_unit_tb();

    import retro_processor_pkg::*;
    import retro_processor_tb_pkg::*;

    logic         clk;
    logic         reset;
    instruction_t instruction;
    alu_flags_t   alu_flags;
    alu_op_t      ALUControl;
    logic         RegWrite;
    reg_addr_t    A3;
    logic         mem_read_enable;
    logic         MemWrite;
    logic         PCSrc;
    logic         ImmSrc;
    logic         halt_signal;

    control_unit dut (
        .clk(clk),
        .reset(reset),
        .instruction(instruction),
        .alu_flags(alu_flags),
        .ALUControl(ALUControl),
        .RegWrite(RegWrite),
        .A3(A3),
        .mem_read_enable(mem_read_enable),
        .MemWrite(MemWrite),
        .PCSrc(PCSrc),
        .ImmSrc(ImmSrc),
        .halt_signal(halt_signal)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    task test_basic_instructions();
        instruction = make_instruction(OP_ADD, 4'd1, 4'd2, 4'd3);
        alu_flags = '{zero: 1'b0, carry: 1'b0, negative: 1'b0, overflow: 1'b0};
        @(posedge clk);
        @(posedge clk);
        
        instruction = make_instruction(OP_LOAD, 4'd5, 4'd6, 4'd0);
        @(posedge clk);
        @(posedge clk);
        
        instruction = make_instruction(OP_HALT, 4'd0, 4'd0, 4'd0);
        @(posedge clk);
        @(posedge clk);
    endtask

    initial begin
        reset = 1'b1;
        instruction = make_instruction(OP_NOP, 0, 0, 0);
        alu_flags = '{zero: 1'b0, carry: 1'b0, negative: 1'b0, overflow: 1'b0};
        
        repeat(5) @(posedge clk);
        reset = 1'b1;
        repeat(3) @(posedge clk);
        reset = 1'b0;
        repeat(2) @(posedge clk);
        
        test_basic_instructions();
        
        #1000;
        $finish;
    end

endmodule : control_unit_unit_tb