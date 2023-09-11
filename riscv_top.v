module riscv_top (
	input    wire			i_CLK    	 ,
	input    wire			i_Reset 	 ,
	input    wire	[31:0]	i_Instr		 ,
	input    wire	[31:0]	i_ReadData	 ,
	output   wire	[31:0]	o_PC		 ,
	output   wire	[31:0]	o_ALUResult	 ,
	output   wire	     	o_MemWrite	 ,
	output   wire	[31:0]	o_WriteData  
	);

wire  		 Zero       ;
wire  [1:0]  PCSrc      ;
wire  [1:0]  ResultSrc  ;
wire  [2:0]  ALUControl ;
wire  		 ALUSrc     ;
wire  [1:0]  ImmSrc     ;
wire  		 RegWrite   ;

riscv_controller controller (
	.i_op		  (i_Instr[6:0])   ,
	.i_funct3	  (i_Instr[14:12]) ,
	.i_funct7	  (i_Instr[30])    ,
	.i_Zero		  (Zero)           ,
	.o_PCSrc	  (PCSrc)          ,
	.o_ResultSrc  (ResultSrc)      ,
	.o_MemWrite	  (o_MemWrite)     ,
	.o_ALUControl (ALUControl)     ,
	.o_ALUSrc	  (ALUSrc)         ,
	.o_ImmSrc	  (ImmSrc)         ,
	.o_RegWrite   (RegWrite)
	);

riscv_datapath datapath (
	.i_CLK    	  (i_CLK)       ,
	.i_Reset 	  (i_Reset)     ,
	.i_Instr      (i_Instr)     ,
	.i_PCSrc	  (PCSrc)       ,
	.i_ResultSrc  (ResultSrc)   ,
	.i_ALUControl (ALUControl)  ,
	.i_ALUSrc	  (ALUSrc)      ,
	.i_ImmSrc	  (ImmSrc)      ,
	.i_RegWrite	  (RegWrite)    ,
	.i_ReadData	  (i_ReadData)  ,
	.o_Zero		  (Zero)        ,
	.o_PC		  (o_PC)        ,
	.o_ALUResult  (o_ALUResult) ,
	.o_WriteData  (o_WriteData)
	);

endmodule
