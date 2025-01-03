module alu (A, B, ALUControl, Result, Z, N, V, C);  // Z = zero flag, N = negative flag, V = overflow flag, C = carry flag

    // declare inputs
    input [31:0] A, B;
    input [2:0] ALUControl;

    // declare outputs
    output reg [31:0] Result;  // Declare as reg for use in always block
    output Z, N, V, C;

    // declaring interim wires
    wire [31:0] a_and_b;
    wire [31:0] a_or_b;
    wire [31:0] not_b;
    wire [31:0] mux_1;
    wire [31:0] sum;
   
    wire Cout;
    wire [31:0] slt;

    // logic design

    // AND operation
    assign a_and_b = A & B;

    // OR operation
    assign a_or_b = A | B;

    // NOT operation on B
    assign not_b = ~B;

    assign mux_1 = (ALUControl[0] == 1'b1) ? not_b : B;

    // Addition and subtraction
    assign {Cout, sum} = A + mux_1 + ALUControl[0];

    // Zero extension
    assign slt = {{31{1'b0}}, sum[31]};

    always @(*) begin
        // ALU operation selection
        case (ALUControl[2:0])
            3'b000: Result = sum;
            3'b001: Result = sum;
            3'b010: Result = a_and_b;
            3'b011: Result = a_or_b;
            3'b100: Result = slt;
            default: Result = {32{1'b0}};
        endcase
    end

    // Flag assignment
    assign Z = &(~Result);  // Zero flag

    assign N = Result[31]; // Negative flag

    assign C = Cout & (~ALUControl[1]); // Carry flag

    assign V = ((~ALUControl[1]) & (A[31] ^ sum[31])) & (~(ALUControl[0] ^ A[31] ^ B[31]));  // Overflow flag

endmodule
