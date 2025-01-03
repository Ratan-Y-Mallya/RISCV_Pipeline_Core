// `include "P_c.v"
// `include "Mux.v"
// `include "Instruction_Memory.v"
// `include "PC_Adder.v"

module fetch_cycle (clk, rst, PCSrcE, PCTargetE, InstrD , PCD,PCPlus4D);

    // Declaring input and output
    input clk,rst;
    input PCSrcE;
    input [31:0] PCTargetE;
    output [31:0] InstrD;
    output [31:0] PCD , PCPlus4D;

    // Interim wire
    wire[31:0] PC_F , PCF , PCPlus4F,InstrF;
   

    // Declare of Register
    reg [31:0] InstrF_reg, PCF_reg,PCPlus4F_reg;
    

    // initiation of modules
    // Declare PC Mux
    Mux  PC_MUX (.a(PCPlus4F),
                 .b(PCTargetE),
                 .s(PCSrcE),
                 .c(PC_F));

    
    //  Declare PC counter
     P_C Program_counter (.PC_NEXT(PC_F) ,
                          .PC(PCF) ,
                          .rst(rst) ,
                          .clk(clk));

            
    //  Declare Instruction memory
     Instr_Mem Memory_item (.A(PCF),
                            .rst(rst),
                            .RD(InstrF));

    // Declare PC adder
    PC_adder Adder_ (.a(PCF),
                     .b(32'h00000004),
                     .c(PCPlus4F));



    // Fetch cycle Register logic
    always @(posedge clk or negedge rst ) begin

        if (rst == 1'b0) begin
            InstrF_reg <=32'h00000000;
            PCF_reg<=32'h00000000;
            PCPlus4F_reg<=32'h00000000;
        end else begin
            
            InstrF_reg <=InstrF;
            PCF_reg<=PCF;
            PCPlus4F_reg<=PCPlus4F;
        
    end

    end

    // Assigning Registers Value to the Output port 
    assign InstrD = (rst == 1'b0) ? 32'h00000000 : InstrF_reg;
    assign PCD = (rst == 1'b0)? 32'h00000000 : PCF_reg;
    assign PCPlus4D = (rst == 1'b0)? 32'h00000000 : PCPlus4F_reg;

endmodule