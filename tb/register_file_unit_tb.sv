module register_file_unit_tb();

    import retro_processor_pkg::*;
    import retro_processor_tb_pkg::*;

    logic       clk;
    logic       reset;
    reg_addr_t  RA1;
    reg_addr_t  RA2;
    data_t      RD1;
    data_t      RD2;
    reg_addr_t  A3;
    data_t      WD3;
    logic       WE3;

    register_file dut (
        .clk(clk),
        .reset(reset),
        .RA1(RA1),
        .RA2(RA2),
        .RD1(RD1),
        .RD2(RD2),
        .A3(A3),
        .WD3(WD3),
        .WE3(WE3)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    task test_basic_operations();
        A3 = 4'd1;
        WD3 = 8'hAA;
        WE3 = 1'b1;
        @(posedge clk);
        WE3 = 1'b0;
        @(posedge clk);
        
        RA1 = 4'd1;
        RA2 = 4'd0;
        @(posedge clk);
        @(posedge clk);
        
        A3 = 4'd2;
        WD3 = 8'h55;
        WE3 = 1'b1;
        @(posedge clk);
        WE3 = 1'b0;
        
        RA1 = 4'd1;
        RA2 = 4'd2;
        @(posedge clk);
        @(posedge clk);
    endtask

    task test_zero_register();
        A3 = REG_ZERO;
        WD3 = 8'hFF;
        WE3 = 1'b1;
        @(posedge clk);
        WE3 = 1'b0;
        
        RA1 = REG_ZERO;
        @(posedge clk);
        @(posedge clk);
    endtask

    initial begin
        reset = 1'b1;
        RA1 = 4'd0;
        RA2 = 4'd0;
        A3 = 4'd0;
        WD3 = 8'h00;
        WE3 = 1'b0;
        
        repeat(5) @(posedge clk);
        reset = 1'b1;
        repeat(3) @(posedge clk);
        reset = 1'b0;
        repeat(2) @(posedge clk);
        
        test_basic_operations();
        test_zero_register();
        
        #1000;
        $finish;
    end

endmodule : register_file_unit_tb