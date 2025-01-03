// `include "Fetch_cycle.v"

module tb ();
reg clk ,rst;
reg PCSrcE;
reg [31:0] PCTargetE;
wire [31:0] InstrD;
wire [31:0] PCD , PCPlus4D;

// Decleration of design under test
fetch_cycle dut (.clk(clk), 
                 .rst(rst), 
                 .PCSrcE(PCSrcE), 
                 .PCTargetE(PCTargetE), 
                 .InstrD(InstrD) , 
                 .PCD(PCD),
                 .PCPlus4D(PCPlus4D));


initial begin
    clk = 1'b0;
end
// Generation of clock
always begin
 #50   
clk =~clk;

end


// Provide the stimulus
initial begin
    rst<=1'b0;
    #200;
    rst<=1'b1;
    PCSrcE <= 1'b0;
    PCTargetE <= 32'h00000000;
    #500;
    $finish;
end

// Generation of vcd
initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
end
    
endmodule