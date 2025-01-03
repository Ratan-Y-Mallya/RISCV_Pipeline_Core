module Sign_Extend (In, Imm_Ext,ImmSrc);

    input [1:0]ImmSrc;
    input [31:0] In;
    output [31:0] Imm_Ext;

    assign Imm_Ext =  (ImmSrc == 2'b00) ? {{20{In[31]}},In[31:20]} : 
                     (ImmSrc == 2'b01) ? {{20{In[31]}},In[31:25],In[11:7]} : 32'h00000000; 

endmodule
