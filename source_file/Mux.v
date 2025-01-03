module Mux (a,b,s,c);

    input [31:0]a,b;
    input s;
    output [31:0]c;

    assign c = (s==1'b0) ? a : b ;
    
endmodule