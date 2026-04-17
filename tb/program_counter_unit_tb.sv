module program_counter_unit_tb
    import retro_processor_pkg::*;
();

    logic     clk;
    logic     reset;
    logic     jump_enable;
    address_t jump_address;
    logic     halt;
    address_t PC;

    program_counter dut (
        .clk(clk),
        .reset(reset),
        .jump_enable(jump_enable),
        .jump_address(jump_address),
        .halt(halt),
        .PC(PC)
    );

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    task test_basic_operations();
        reset = 1'b1;
        #20;
        reset = 1'b0;
        #10;
        
        repeat(5) @(posedge clk);
        
        jump_address = 8'h50;
        jump_enable = 1'b1;
        @(posedge clk);
        jump_enable = 1'b0;
        
        repeat(3) @(posedge clk);
    endtask

    initial begin
        reset = 1'b0;
        jump_enable = 1'b0;
        jump_address = 8'h00;
        halt = 1'b0;
        
        #1;
        
        test_basic_operations();
        
        #1000;
        $finish;
    end

endmodule : program_counter_unit_tb