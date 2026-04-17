module retro_processor_integration_tb;

    import retro_processor_pkg::*;
    import retro_processor_tb_pkg::*;

    logic clk;
    logic reset;
    address_t debug_pc;
    instruction_t debug_instruction;
    data_t debug_reg_data_a;
    data_t debug_reg_data_b;
    alu_flags_t debug_alu_flags;
    logic debug_halted;
    
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end
    
    retro_processor dut (
        .clk(clk),
        .reset(reset),
        .debug_pc(debug_pc),
        .debug_instruction(debug_instruction),
        .debug_reg_data_a(debug_reg_data_a),
        .debug_reg_data_b(debug_reg_data_b),
        .debug_alu_flags(debug_alu_flags),
        .debug_halted(debug_halted)
    );
    
    task test_basic_execution();
        reset = 1'b1;
        repeat(3) @(posedge clk);
        reset = 1'b0;
        
        repeat (200) begin
            @(posedge clk);
            if (debug_halted) begin
                break;
            end
        end
    endtask
    
    initial begin
        reset = 1'b0;
        
        test_basic_execution();
        
        #1000;
        $finish;
    end

endmodule : retro_processor_integration_tb