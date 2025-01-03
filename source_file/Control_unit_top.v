`include "Alu_decoder.v"
`include "main_decoder.v"

module Control_Unit_Top(Op,RegWrite,ImmSrc,ALUSrc,MemWrite,ResultSrc,Branch,funct3,funct7,ALUControl);

    input [6:0]Op,funct7;
    input [2:0]funct3;
    output RegWrite,ALUSrc,MemWrite,ResultSrc,Branch;
    output [1:0]ImmSrc;
    output [2:0]ALUControl;

    wire [1:0]ALUOp;

 main_decoder Main_Decoder(.Op(Op),
                        //    .zero(),
                           .RegWrite(RegWrite),
                           .MemWrite(MemWrite),
                           .ImmSrc(ImmSrc),
                           .ALUSrc(ALUSrc),
                           .ResultSrc(ResultSrc),
                           /*.PCSrc(),*/
                           .ALUOp(ALUOp),
                           .Branch(Branch)
                           );

alu_decoder ALU_decoder (.ALUOp(ALUOp), 
                         .funct3(funct3),
                         .funct7(funct7),
                         .ALUControl(ALUControl),
                         .Op(Op));

endmodule