// `include "Control_unit_top.v"
// `include "Register_files.v"
// `include "Sign_Extend.v"

module decode_cycle (clk , rst , InstrD , PCD, PCPlus4D , RegWriteW ,RDW,ResultW,RegWriteE, ALUSrcE, MemWriteE, ResultSrcE, BranchE,  ALUControlE, RD1_E, RD2_E, Imm_Ext_E, RD_E, PCE, PCPlus4E,Rs1_E,Rs2_E);

 // Declare I/O
 input clk, rst ,RegWriteW ;
 input [4:0] RDW;
 input [31:0]InstrD,PCD,PCPlus4D ,ResultW;

output RegWriteE,ALUSrcE,MemWriteE,ResultSrcE,BranchE;
output [2:0] ALUControlE;
output [31:0] RD1_E, RD2_E, Imm_Ext_E;
output [4:0]  RD_E,Rs1_E,Rs2_E;
output [31:0] PCE, PCPlus4E;

//  Declare Interim wires
    wire RegWriteD,MemWriteD,/*JumpD*/ BranchD ,ALUSrcD ,ResultSrcD;
    wire [1:0]  ImmSrcD ;
    wire [2:0] ALUControlD;
    wire [31:0] RD1_D,RD2_D,ImmExtD;

// Declaration of interim reg
    reg RegWriteD_r,MemWriteD_r,/*JumpD_r*/ BranchD_r ,ALUSrcD_r ,ResultSrcD_r;
    reg [2:0] ALUControlD_r;
    reg [31:0] RD1_D_r,RD2_D_r,ImmExtD_r;
    reg [4:0] RD_D_r,Rs1_D_r,Rs2_D_r;
    reg [31:0] PCD_r , PCPlus4D_r;


// Initiate the modules
//  Control Unit
    Control_Unit_Top Control(   .Op(InstrD[6:0]),
                                .RegWrite(RegWriteD),
                                .ImmSrc(ImmSrcD),
                                .ALUSrc(ALUSrcD),
                                .MemWrite(MemWriteD),
                                .ResultSrc(ResultSrcD),
                                .Branch(BranchD),
                                .funct3(InstrD[14:12]),
                                .funct7(InstrD[31:25]),
                                .ALUControl(ALUControlD)
                                );

                            
// Register File 
    Reg_file rf (.A1(InstrD[19:15]), 
                 .A2(InstrD[24:20]),
                 .A3(RDW), 
                 .WD3(ResultW), 
                 .WE3(RegWriteW),
                 .clk(clk),
                 .rst(rst), 
                 .RD1(RD1_D), 
                 .RD2(RD2_D));


 // Extend file
    Sign_Extend extension (.In(InstrD[31:0]), 
                           .Imm_Ext(ImmExtD),
                           .ImmSrc(ImmSrcD)
                           );


// Declaring Register logic
 always @(posedge clk or negedge rst) begin
        if(rst == 1'b0) begin
            RegWriteD_r <= 1'b0;
            ALUSrcD_r <= 1'b0;
            MemWriteD_r <= 1'b0;
            ResultSrcD_r <= 1'b0;
            BranchD_r <= 1'b0;
            ALUControlD_r <= 3'b000;
            RD1_D_r <= 32'h00000000; 
            RD2_D_r <= 32'h00000000; 
            ImmExtD_r <= 32'h00000000;
            RD_D_r <= 5'h00;
            PCD_r <= 32'h00000000; 
            PCPlus4D_r <= 32'h00000000;
            Rs1_D_r <=5'h00;
            Rs2_D_r <= 5'h00;
           
        end
        else begin
            RegWriteD_r <= RegWriteD;
            ALUSrcD_r <= ALUSrcD;
            MemWriteD_r <= MemWriteD;
            ResultSrcD_r <= ResultSrcD;
            BranchD_r <= BranchD;
            ALUControlD_r <= ALUControlD;
            RD1_D_r <= RD1_D; 
            RD2_D_r <= RD2_D; 
            ImmExtD_r <= ImmExtD;
            RD_D_r <= InstrD[11:7];
            PCD_r <= PCD; 
            PCPlus4D_r <= PCPlus4D;
            Rs1_D_r <= InstrD[19:15];
            Rs2_D_r <= InstrD[24:20];
         
        end
    end

// Output asssign statements
    assign RegWriteE = RegWriteD_r;
    assign ALUSrcE = ALUSrcD_r;
    assign MemWriteE = MemWriteD_r;
    assign ResultSrcE = ResultSrcD_r;
    assign BranchE = BranchD_r;
    assign ALUControlE = ALUControlD_r;
    assign RD1_E = RD1_D_r;
    assign RD2_E = RD2_D_r;
    assign Imm_Ext_E = ImmExtD_r;
    assign RD_E = RD_D_r;
    assign PCE = PCD_r;
    assign PCPlus4E = PCPlus4D_r;
    assign Rs1_E = Rs1_D_r;
    assign Rs2_E = Rs2_D_r;
  
endmodule


