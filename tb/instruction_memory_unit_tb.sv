module instruction_memory_unit_tb;

    import retro_processor_pkg::*;
    import retro_processor_tb_pkg::*;

    logic clk;
    address_t A;
    instruction_t RD;

    instruction_memory dut (
        .clk(clk),
        .A(A),
        .RD(RD)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task test_basic_functionality();
        A = 8'h00;
        @(posedge clk);
        @(posedge clk);
        
        A = 8'h01;
        @(posedge clk);
        @(posedge clk);
        
        A = 8'h02;
        @(posedge clk);
        @(posedge clk);
    endtask

    initial begin
        A = 8'h00;
        
        repeat(5) @(posedge clk);
        
        test_basic_functionality();
        
        #1000;
        $finish;
    end

endmodule : instruction_memory_unit_tb