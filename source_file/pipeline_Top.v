
`include "Fetch_cycle.v"
`include "Decode_cycle.v"
`include "Execute_cycle.v"
`include "Memory_cycle.v"
`include "Writeback_cycle.v"
`include "P_c.v"
`include "Instruction_Memory.v"
`include "Register_files.v"
`include "Sign_Extend.v"
`include "ALU.v"
`include "Control_unit_top.v"
`include "Data_Mem.v"
`include "PC_Adder.v"
`include "Mux.v"
`include "Hazard_unit.v"
`include "Mux_3_by_1.v"



module pipeline_top (clk , rst );

    // Declaration of I/O
    input clk , rst;

    // Declaration of wire
    wire PCSrcE,RegWriteW,ResultSrcW,ResultSrcM,RegWriteE,ALUSrcE,MemWriteM,MemWriteE,ResultSrcE,BranchE,RegWriteM;
    wire [31:0] PCTargetE ,InstrD , PCD , PCPlus4D,ResultW,RD1_E,RD2_E,Imm_Ext_E,PCE,PCPlus4E;
    wire [4:0] RDW,RD_E,RD_M,RD_W,Rs1_E,Rs2_E;
    wire [2:0] ALUControlE;
    wire [31:0] PCPlus4M,WriteDataM,ALU_ResultW,ReadDataW,ALU_ResultM,PCPlus4W,WriteDataW;
    wire [1:0]ForwardA_E,ForwardB_E;

    // Module Intiation
    // Fetch Cycle
    fetch_cycle Fetch (.clk(clk), 
                        .rst(rst), 
                        .PCSrcE(PCSrcE), 
                        .PCTargetE(PCTargetE), 
                        .InstrD(InstrD) , 
                        .PCD(PCD),
                        .PCPlus4D(PCPlus4D)
                        );


    // Decode cycle
    decode_cycle Decode (.clk(clk) , 
                         .rst(rst) , 
                         .InstrD(InstrD) , 
                         .PCD(PCD), 
                         .PCPlus4D(PCPlus4D) , 
                         .RegWriteW(RegWriteW) ,
                         .RDW(RDW),
                         .ResultW(ResultW),
                         .RegWriteE(RegWriteE), 
                         .ALUSrcE(ALUSrcE), 
                         .MemWriteE(MemWriteE), 
                         .ResultSrcE(ResultSrcE),
                         .BranchE(BranchE) ,  
                         .ALUControlE(ALUControlE), 
                         .RD1_E(RD1_E), 
                         .RD2_E(RD2_E), 
                         .Imm_Ext_E(Imm_Ext_E), 
                         .RD_E(RD_E), 
                         .PCE(PCE), 
                         .PCPlus4E(PCPlus4E),
                         .Rs1_E(Rs1_E),
                         .Rs2_E(Rs2_E)
                         );


    // Execute cycle
    execute_cycle Execute (.clk(clk), 
                           .rst(rst), 
                           .RegWriteE(RegWriteE), 
                           .ALUSrcE(ALUSrcE), 
                           .MemWriteE(MemWriteE), 
                           .ResultSrcE(ResultSrcE), 
                           .BranchE(BranchE), 
                           .ALUControlE(ALUControlE), 
                           .RD1_E(RD1_E), 
                           .RD2_E(RD2_E), 
                           .Imm_Ext_E(Imm_Ext_E), 
                           .RD_E(RD_E), 
                           .PCE(PCE), 
                           .PCPlus4E(PCPlus4E), 
                           .PCSrcE(PCSrcE), 
                           .PCTargetE(PCTargetE), 
                           .RegWriteM(RegWriteM), 
                           .MemWriteM(MemWriteM), 
                           .ResultSrcM(ResultSrcM), 
                           .RD_M(RD_M), 
                           .PCPlus4M(PCPlus4M), 
                           .WriteDataM(WriteDataM), 
                           .ALU_ResultM(ALU_ResultM),
                           .ResultW(ResultW),
                           .ForwardA_E(ForwardA_E), 
                           .ForwardB_E(ForwardB_E)
                           );

    // Memory cycle
    memory_cycle  Memory (.rst(rst) ,
                          .clk(clk) ,
                          // .PCSrcE(PCSrcE), 
                          .RegWriteM(RegWriteM), 
                          .MemWriteM(MemWriteM), 
                          .ResultSrcM(ResultSrcM),
                          .RD_M(RD_M) ,
                          .PCPlus4M(PCPlus4M), 
                          .WriteDataM(WriteDataM), 
                          .ALU_ResultM(ALU_ResultM) , 
                        //   .PCTargetE(PCTargetE),
                          .RegWriteW(RegWriteW) ,
                          .ResultSrcW(ResultSrcW),
                          .RD_W(RDW),
                          .PCPlus4W(PCPlus4W), 
                          // .WriteDataW(WriteDataW), 
                          .ReadDataW(ReadDataW),
                          .ALU_ResultW(ALU_ResultW)
                          );
    
    // Writeback cycle
    writeback_cycle Writeback (.clk(clk), 
                               .rst(rst), 
                               .ResultSrcW(ResultSrcW), 
                               .PCPlus4W(PCPlus4W), 
                               .ALU_ResultW(ALU_ResultW), 
                               .ReadDataW(ReadDataW), 
                               .ResultW(ResultW)
                               );

    // Hazard Unit
    hazard_unit hazard (.rst(rst),
                        .RegWriteM(RegWriteM),
                        .RegWriteW(RegWriteW),
                        .RD_M(RD_M) ,
                        .RD_W(RDW),
                        .Rs1_E(Rs1_E),
                        .Rs2_E(Rs2_E),
                        .ForwardAE(ForwardA_E),
                        .ForwardBE(ForwardB_E)
                        );

endmodule