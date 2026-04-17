module alu_unit_tb();

    import retro_processor_pkg::*;
    import retro_processor_tb_pkg::*;

    logic     clk;
    data_t    SrcA;
    data_t    SrcB;
    alu_op_t  ALUControl;
    data_t    ALUResult;
    alu_flags_t ALUFlags;

    alu dut (
        .clk(clk),
        .SrcA(SrcA),
        .SrcB(SrcB),
        .ALUControl(ALUControl),
        .ALUResult(ALUResult),
        .ALUFlags(ALUFlags)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    task test_basic_operations();
        SrcA = 8'h05;
        SrcB = 8'h03;
        ALUControl = ALU_ADD;
        @(posedge clk);
        @(posedge clk);
        
        SrcA = 8'h05;
        SrcB = 8'h03;
        ALUControl = ALU_SUB;
        @(posedge clk);
        @(posedge clk);
        
        SrcA = 8'hFF;
        SrcB = 8'h0F;
        ALUControl = ALU_AND;
        @(posedge clk);
        @(posedge clk);
        
        SrcA = 8'hF0;
        SrcB = 8'h0F;
        ALUControl = ALU_OR;
        @(posedge clk);
        @(posedge clk);
        
        SrcA = 8'h80;
        ALUControl = ALU_SHL;
        @(posedge clk);
        @(posedge clk);
        
        SrcA = 8'h01;
        ALUControl = ALU_SHR;
        @(posedge clk);
        @(posedge clk);
    endtask

    initial begin
        SrcA = 8'b0;
        SrcB = 8'b0;
        ALUControl = ALU_ADD;
        
        repeat(5) @(posedge clk);
        
        test_basic_operations();
        
        #1000;
        $finish;
    end

endmodule : alu_unit_tb