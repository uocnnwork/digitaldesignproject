module register_file (
    input  logic        clk,
    input  logic        reset,
    input  logic [3:0]  RA1,
    input  logic [3:0]  RA2,
    output logic [7:0]  RD1,
    output logic [7:0]  RD2,
    input  logic [3:0]  A3,
    input  logic [7:0]  WD3,
    input  logic        WE3
);

    import retro_processor_pkg::*;

    logic [7:0] registers [15:0];
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            for (int i = 0; i < 16; i++) begin
                registers[i] <= 8'h00;
            end
        end else if (WE3) begin
            if (A3 != 4'd0) begin
                registers[A3] <= WD3;
            end
        end
    end
    
    assign RD1 = (RA1 == 4'd0) ? 8'h00 : registers[RA1];
    assign RD2 = (RA2 == 4'd0) ? 8'h00 : registers[RA2];

endmodule : register_file