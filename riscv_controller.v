module riscv_controller (
	input    wire	[6:0]	i_op		 ,
	input    wire	[2:0]	i_funct3	 ,
	input    wire			i_funct7	 ,
	input    wire			i_Zero		 ,
	output   wire	[1:0]	o_PCSrc		 ,
	output   wire	[1:0]	o_ResultSrc  ,
	output   wire			o_MemWrite	 ,
	output   wire	[2:0]	o_ALUControl ,
	output   wire			o_ALUSrc	 ,
	output   wire	[1:0]	o_ImmSrc	 ,
	output   wire			o_RegWrite
	);

wire  		 Branch  ;
wire  		 BeqBne  ;
wire  		 Jump    ;
wire  		 ImmJump ;
wire  [1:0]  ALUOp   ;
	
main_decoder cu1_main_decoder (
	.i_op		 (i_op)		   ,
	.o_Branch	 (Branch)	   ,
	.o_Jump		 (Jump)		   ,
	.o_ImmJump   (ImmJump)     ,
	.o_ResultSrc (o_ResultSrc) ,
	.o_MemWrite  (o_MemWrite)  ,
	.o_ALUSrc    (o_ALUSrc)    ,
	.o_ImmSrc    (o_ImmSrc)    ,
	.o_RegWrite  (o_RegWrite)  ,
	.o_ALUOp     (ALUOp)
	);

alu_decoder cu2_alu_decoder (
	.i_ALUOp      (ALUOp)	     ,
	.i_op		  (i_op[5])		 ,
	.i_funct3	  (i_funct3)	 ,
	.i_funct7     (i_funct7)     ,
	.o_ALUControl (o_ALUControl)
	);

//bne instruction enhancement
assign BeqBne = (!i_funct3[0])? 
	( i_Zero & Branch) : //funct3(beq)=000 
	(~i_Zero & Branch) ; //funct3(bne)=001

assign o_PCSrc = {ImmJump , (BeqBne | Jump)} ;

endmodule
