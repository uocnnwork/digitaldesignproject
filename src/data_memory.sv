module data_memory (
    input  logic     clk,
    input  logic     reset,
    input  logic [7:0] A,
    input  logic [7:0]    WD,
    input  logic     read_enable,
    input  logic     WE,
    output logic [7:0]    RD
);

    import retro_processor_pkg::*;

    logic [7:0] memory [0:255];
    
    always_ff @(posedge clk) begin
        if (reset) begin
            for (int i = 0; i < 256; i++) begin
                memory[i] <= 8'h00;
            end
        end else begin
            if (WE) begin
                if (A <= 8'h7F || A >= 8'h80) begin
                    memory[A] <= WD;
                end
            end
        end
    end
    
    assign RD = read_enable ? memory[A] : 8'h00;

endmodule : data_memory