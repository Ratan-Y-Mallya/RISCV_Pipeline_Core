module Reg_file (A1, A2, A3, WD3, WE3, clk, rst, RD1, RD2);

    // Inputs
    input [31:0] WD3;
    input clk, rst, WE3;
    input [4:0] A1, A2, A3;

    // Outputs
    output [31:0] RD1, RD2;

    // Creation of memory
    reg [31:0] Registers [31:0];

    // Read functionality
    assign RD1 = (!rst) ? 32'h00000000 : Registers[A1];
    assign RD2 = (!rst) ? 32'h00000000 : Registers[A2];

    // Write functionality
    always @(posedge clk) begin
        if (WE3 & (A3 != 5'h00)) begin
            Registers[A3] <= WD3;
        end
    end

    initial begin
        Registers[0]=32'h00000000;
    end

endmodule
