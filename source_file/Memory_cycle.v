// `include "Data_Mem.v"


module memory_cycle(rst , clk , RegWriteM, MemWriteM, ResultSrcM,RD_M ,PCPlus4M, WriteDataM, ALU_ResultM /*, PCTargetE*/,RegWriteW ,ResultSrcW,RD_W,PCPlus4W, ReadDataW,ALU_ResultW);
    

    // Declaration of I/O
    input  RegWriteM, MemWriteM, ResultSrcM, clk , rst;
    input [4:0] RD_M; 
    input [31:0] PCPlus4M, WriteDataM, ALU_ResultM;
    /*input [31:0] PCTargetE;*/

    output RegWriteW ,ResultSrcW;
    output [4:0] RD_W; 
    output [31:0] PCPlus4W, ALU_ResultW,ReadDataW;

    // Declaration of interim wires
    wire [31:0] ReadDataM ;


    // Declaration of register
    reg RegWriteM_r,  ResultSrcM_r;
    reg [4:0] RD_M_r; 
    reg [31:0] PCPlus4M_r,/* WriteDataM_r,*/ ALU_ResultM_r,/* PCTargetE_r ,*/ ReadDataM_r;


     // Declaration of Modules
    Data_Menmory dmem ( .A(ALU_ResultM),
                        .WD(WriteDataM),
                        .clk(clk),
                        .WE(MemWriteM),
                        .RD(ReadDataM),
                        .rst(rst)
                        );

    // Memory stage Register Logic
    always @(posedge clk or negedge rst) begin
        if (rst==1'b0) begin
             RegWriteM_r<=1'b0;
             ResultSrcM_r<=1'b0;
             RD_M_r<=5'b00000;
             PCPlus4M_r<=32'h00000000;
            //  WriteDataM_r<=32'h00000000;
             ALU_ResultM_r<=32'h00000000;
             ReadDataM_r<=32'h00000000;


        end else begin

             RegWriteM_r<=RegWriteM;
             ResultSrcM_r<=ResultSrcM;
             RD_M_r<=RD_M;
             PCPlus4M_r<=PCPlus4M;
            //  WriteDataM_r<=WriteDataM;
             ALU_ResultM_r<=ALU_ResultM;
             ReadDataM_r<=ReadDataM;
            
        end        
    end

    // Declaration of output assignment
    assign RegWriteW = RegWriteM_r;
    assign ResultSrcW = ResultSrcM_r;
    assign RD_W = RD_M_r;
    assign PCPlus4W = PCPlus4M_r;
    // assign WriteDataW = WriteDataM_r;
    assign ALU_ResultW = ALU_ResultM_r;
    assign ReadDataW = ReadDataM_r;

endmodule