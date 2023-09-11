module riscv_datapath (
	input    wire			i_CLK    	 ,
	input    wire			i_Reset 	 ,
	input    wire	[31:0]	i_Instr		 ,
	input    wire	[1:0]	i_PCSrc		 ,
	input    wire	[1:0]	i_ResultSrc  ,
	input    wire	[2:0]	i_ALUControl ,
	input    wire			i_ALUSrc	 ,
	input    wire	[1:0]	i_ImmSrc	 ,
	input    wire			i_RegWrite	 ,
	input    wire	[31:0]	i_ReadData	 ,
	output   wire			o_Zero		 ,
	output   wire	[31:0]	o_PC		 ,
	output   wire	[31:0]	o_ALUResult	 ,
	output   wire	[31:0]	o_WriteData  
	);

wire  [31:0] RD1       ;
wire  [31:0] RD2       ;
wire  [31:0] ImmExt    ;
wire  [31:0] SrcB      ;
wire  [31:0] ALUResult ;
wire  [31:0] Result    ;
wire  [31:0] PCPlus4   ;
wire  [31:0] PCTarget  ;
wire  [31:0] PCNext    ;
wire  [31:0] PC        ;

	
regfile du1_regfile (
	.i_CLK	 (i_CLK)	      ,
	.i_Reset (i_Reset)        , 
	.i_A1	 (i_Instr[19:15]) ,
	.i_A2	 (i_Instr[24:20]) ,
	.i_A3	 (i_Instr[11:7])  ,
	.i_WE3	 (i_RegWrite)     ,
	.i_WD3	 (Result)		  , //from Result Mux
	.o_RD1	 (RD1)		      ,
	.o_RD2	 (RD2)		  
	);

extend du2_extend (
	.i_Imm    (i_Instr[31:7]) ,
	.i_ImmSrc (i_ImmSrc)      ,
	.o_ImmExt (ImmExt)
	);

mux2 du3_mux (
	.i_DataInA (RD2)      ,
	.i_DataInB (ImmExt)   ,
	.i_Select  (i_ALUSrc) ,
	.o_DataOut (SrcB)
	);

alu du4_alu (
	.i_SrcA       (RD1)          ,
	.i_SrcB       (SrcB)         ,
	.i_ALUControl (i_ALUControl) ,
	.o_Zero       (o_Zero)       ,
	.o_ALUResult  (ALUResult)
	);

mux3 du5_mux (
	.i_DataInA (ALUResult)   ,
	.i_DataInB (i_ReadData)  ,
	.i_DataInC (PCPlus4)     ,
	.i_Select  (i_ResultSrc) ,
	.o_DataOut (Result)
	);

adder du6_adder (
	.i_SrcA        (PC)        ,
	.i_SrcB        (32'd4)     ,
	.o_AdderResult (PCPlus4)
	);

adder du7_adder (
	.i_SrcA        (PC)        ,
	.i_SrcB        (ImmExt)    ,
	.o_AdderResult (PCTarget)
	);

mux3 du8_mux (
	.i_DataInA (PCPlus4)   ,
	.i_DataInB (PCTarget)  ,
	.i_DataInC (ALUResult) ,
	.i_Select  (i_PCSrc)   ,
	.o_DataOut (PCNext)
	);

dff du9_dff (
	.i_D     (PCNext)  ,
	.i_CLK   (i_CLK)   ,
	.i_Reset (i_Reset) ,
	.o_Q     (PC)
	);

assign o_ALUResult = ALUResult ;
assign o_PC        = PC        ;
assign o_WriteData = RD2 	   ;

endmodule
