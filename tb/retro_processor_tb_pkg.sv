package retro_processor_tb_pkg;

    import retro_processor_pkg::*;

    typedef enum {
        TEST_PASS,
        TEST_FAIL,
        TEST_PENDING
    } test_result_t;

    typedef struct {
        string test_name;
        test_result_t result;
        string error_message;
    } test_case_t;

    typedef struct {
        int total_tests;
        int passed_tests;
        int failed_tests;
        int pending_tests;
    } test_stats_t;

    test_stats_t global_stats = '{0, 0, 0, 0};

    task automatic generate_clock(ref logic clk, input int half_period_ns = 5);
        forever begin
            #half_period_ns clk = ~clk;
        end
    endtask

    task automatic apply_reset(ref logic reset, ref logic clk, input int reset_cycles = 2);
        reset = 1'b1;
        repeat(reset_cycles) @(posedge clk);
        reset = 1'b0;
    endtask

endpackage : retro_processor_tb_pkg