module data_memory_unit_tb
    import retro_processor_pkg::*,
           retro_processor_tb_pkg::*;
();

    logic clk;
    logic reset;
    address_t A;
    data_t    WD;
    logic     read_enable;
    logic     WE;
    data_t    RD;
    
    data_memory dut (
        .clk(clk),
        .reset(reset),
        .A(A),
        .WD(WD),
        .read_enable(read_enable),
        .WE(WE),
        .RD(RD)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    task test_basic_operations();
        A = 8'h10;
        WD = 8'hAA;
        WE = 1;
        read_enable = 0;
        @(posedge clk);
        WE = 0;
        @(posedge clk);
        
        A = 8'h10;
        read_enable = 1;
        @(posedge clk);
        @(posedge clk);
        read_enable = 0;
    endtask
    
    initial begin
        reset = 1;
        A = 0;
        WD = 0;
        read_enable = 0;
        WE = 0;
        
        repeat(2) @(posedge clk);
        reset = 0;
        repeat(2) @(posedge clk);
        
        test_basic_operations();
        
        #1000;
        $finish;
    end

endmodule : data_memory_unit_tb