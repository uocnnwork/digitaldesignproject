module program_counter (
    input  logic     clk,
    input  logic     reset,
    input  logic     jump_enable,
    input  logic [7:0] jump_address,
    input  logic     halt,
    output logic [7:0] PC
);

    import retro_processor_pkg::*;

    logic [7:0] pc_reg;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_reg <= 8'h00;
        end else if (halt) begin
            pc_reg <= pc_reg;
        end else if (jump_enable) begin
            pc_reg <= jump_address;
        end else begin
            pc_reg <= pc_reg + 1'b1;
        end
    end

    assign PC = pc_reg;

endmodule : program_counter