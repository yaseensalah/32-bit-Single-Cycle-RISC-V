module main_decoder (
	input    wire	[6:0]	i_op		,
	output   reg			o_Branch	,
	output   reg			o_Jump	 	,
	output   reg			o_ImmJump   , //jalr instruction enhancement
	output   reg	[1:0]	o_ResultSrc , //Values are defined in Figure 7.17
	output   reg			o_MemWrite	,
	output   reg			o_ALUSrc	,
	output   reg	[1:0]	o_ImmSrc	, //Values are defined in Table 7.5
	output   reg			o_RegWrite  ,
	output   reg	[1:0]	o_ALUOp       //Values are defined in Table 7.3
	);

always @(*) 
	begin
		case (i_op)
		//-- R-instructions
		7'b0110011: //add,sub,and,or
			begin
				o_Branch	= 1'b0  ;
				o_Jump	 	= 1'b0  ;
				o_ImmJump   = 1'b0  ;
				o_ResultSrc = 2'b00 ;
				o_MemWrite	= 1'b0  ;
				o_ALUSrc	= 1'b0  ;
				o_ImmSrc	= 2'b00 ;
				o_RegWrite  = 1'b1  ;
				o_ALUOp		= 2'b10 ;
			end

		//-- I-instructions
		7'b0010011: //addi,andi,ori
			begin
				o_Branch	= 1'b0  ;
				o_Jump	 	= 1'b0  ;
				o_ImmJump   = 1'b0  ;
				o_ResultSrc = 2'b00 ;
				o_MemWrite	= 1'b0  ;
				o_ALUSrc	= 1'b1  ;
				o_ImmSrc	= 2'b00 ;
				o_RegWrite  = 1'b1  ;
				o_ALUOp		= 2'b10 ;
			end
		7'b0000011: //lw
			begin
				o_Branch	= 1'b0  ;
				o_Jump	 	= 1'b0  ;
				o_ImmJump   = 1'b0  ;
				o_ResultSrc = 2'b01 ;
				o_MemWrite	= 1'b0  ;
				o_ALUSrc	= 1'b1  ;
				o_ImmSrc	= 2'b00 ; 
				o_RegWrite  = 1'b1  ;
				o_ALUOp		= 2'b00 ;
			end
		7'b1100111: //jalr
			begin
				o_Branch	= 1'b0  ;
				o_Jump	 	= 1'b0  ;
				o_ImmJump   = 1'b1  ;
				o_ResultSrc = 2'b10 ;
				o_MemWrite	= 1'b0  ;
				o_ALUSrc	= 1'b1  ;
				o_ImmSrc	= 2'b00 ;
				o_RegWrite  = 1'b1  ;
				o_ALUOp		= 2'b10 ;
			end

		//-- B-instructions
		7'b1100011: //beq,bne
			begin
				o_Branch	= 1'b1  ;
				o_Jump	 	= 1'b0  ;
				o_ImmJump   = 1'b0  ;
				o_ResultSrc = 2'b00 ;
				o_MemWrite	= 1'b0  ;
				o_ALUSrc	= 1'b0  ;
				o_ImmSrc	= 2'b10 ;
				o_RegWrite  = 1'b0  ;
				o_ALUOp		= 2'b01 ;
			end

		//-- J-instructions
		7'b1101111: //jal
			begin
				o_Branch	= 1'b0  ;
				o_Jump	 	= 1'b1  ;
				o_ImmJump   = 1'b0  ;
				o_ResultSrc = 2'b10 ;
				o_MemWrite	= 1'b0  ;
				o_ALUSrc	= 1'b0  ;
				o_ImmSrc	= 2'b11 ;
				o_RegWrite  = 1'b1  ;
				o_ALUOp		= 2'b00 ;
			end

		//-- S-instructions
		7'b0100011: //sw
			begin
				o_Branch	= 1'b0  ;
				o_Jump	 	= 1'b0  ;
				o_ImmJump   = 1'b0  ;
				o_ResultSrc = 2'b00 ;
				o_MemWrite	= 1'b1  ;
				o_ALUSrc	= 1'b1  ;
				o_ImmSrc	= 2'b01 ;
				o_RegWrite  = 1'b0  ;
				o_ALUOp		= 2'b00 ;			
			end

		//-- Default Case
		default: 
			begin
				o_Branch	= 1'b0  ;
				o_Jump	 	= 1'b0  ;
				o_ImmJump   = 1'b0  ;
				o_ResultSrc = 2'b00 ;
				o_MemWrite	= 1'b0  ;
				o_ALUSrc	= 1'b0  ;
				o_ImmSrc	= 2'b00 ;
				o_RegWrite  = 1'b0  ;
				o_ALUOp		= 2'b00 ;			
			end
		endcase
	end


endmodule
