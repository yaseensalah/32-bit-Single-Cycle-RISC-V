module extend (
	input    wire	[31:7]	i_Imm    ,
	input    wire	[1:0]	i_ImmSrc ,
	output   reg	[31:0]	o_ImmExt  
	);

always @(*) 
	begin
		case (i_ImmSrc)
		2'b00: //-- I-instructions
			begin
				o_ImmExt = { {20{i_Imm[31]}} , i_Imm[31:20] } ;
			end
		2'b01: //-- S-instructions
			begin
				o_ImmExt = { {20{i_Imm[31]}} , i_Imm[31:25] , i_Imm[11:7] } ;
			end
		2'b10: //-- B-instructions
			begin
				o_ImmExt = { {20{i_Imm[31]}} , i_Imm[7] , i_Imm[30:25] , i_Imm[11:8] , 1'b0 } ;
			end
		2'b11: //-- J-instructions
			begin
				o_ImmExt = { {12{i_Imm[31]}} , i_Imm[19:12] , i_Imm[20] , i_Imm[30:21] , 1'b0 } ;
			end
		default:
			begin
				o_ImmExt = 32'b0 ;
			end
		endcase
	end


endmodule