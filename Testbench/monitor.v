reg [31:0] rd_reg   ; // Destination Register

always @(negedge CLK_tb) 
	begin
		rd_reg = Instr_tb[11:7] ;

		case (Instr_tb[6:0])
		//-- R-instructions
		7'b0110011: //add,sub,and,or
			begin
				case (Instr_tb[14:12])
				3'b000:
					begin
						if ({Instr_tb[5] , Instr_tb[30]} == 2'b11)
							begin
								$display("PC=%h %s Instruction | expected x%0d=%0d, actual is %0d" ,
									 	  PC_tb , "SUB " , rd_reg , rd_value , RISCV_DUT.datapath.Result) ;
							end
						else 
							begin
								$display("PC=%h %s Instruction | expected x%0d=%0d, actual is %0d" ,
										  PC_tb , "ADD " , rd_reg , rd_value , RISCV_DUT.datapath.Result) ;
							end
					end
				3'b110:
					begin
						$display("PC=%h %s Instruction | expected x%0d=%0d, actual is %0d" , 
								  PC_tb , "OR  " , rd_reg , rd_value , RISCV_DUT.datapath.Result) ;
					end
				3'b111:
					begin
						$display("PC=%h %s Instruction | expected x%0d=%0d, actual is %0d" ,
								  PC_tb , "AND " , rd_reg , rd_value , RISCV_DUT.datapath.Result) ;
					end
				endcase
			end

		//-- I-instructions
		7'b0010011: //addi,andi,ori
			begin
				case (Instr_tb[14:12])
				3'b000:
					begin
						$display("PC=%h %s Instruction | expected x%0d=%0d, actual is %0d" , 
								  PC_tb , "ADDI" , rd_reg , rd_value , RISCV_DUT.datapath.Result) ;
					end
				3'b110:
					begin
						$display("PC=%h %s Instruction | expected x%0d=%0d, actual is %0d" , 
								  PC_tb , "ORI " , rd_reg , rd_value , RISCV_DUT.datapath.Result) ;
					end
				3'b111:
					begin
						$display("PC=%h %s Instruction | expected x%0d=%0d, actual is %0d" ,
							      PC_tb , "ANDI" , rd_reg , rd_value , RISCV_DUT.datapath.Result) ;
					end
				endcase
			end
		7'b0000011: //lw
			begin
				case (Instr_tb[14:12])
				3'b010:
					begin
						$display("PC=%h %s Instruction | expected x%0d=%0d, actual is %0d" ,
							      PC_tb , "LW  " , rd_reg , rd_value , RISCV_DUT.datapath.Result) ;
					end
				endcase
			end
		7'b1100111: //jalr
			begin
				case (Instr_tb[14:12])
				3'b000:
					begin
						$display("PC=%h %s Instruction | expected x%0d=%0d, actual is %0d" , 
								  PC_tb , "JALR" , rd_reg , rd_value , RISCV_DUT.datapath.Result) ;
					end
				endcase
			end

		//-- B-instructions
		7'b1100011: //beq,bne
			begin
				case (Instr_tb[14:12])
				3'b000:
					begin
						$display("PC=%h %s Instruction" , 
								  PC_tb , "BEQ ") ;
					end
				3'b001:
					begin
						$display("PC=%h %s Instruction" , 
								  PC_tb , "BNE ") ;
					end
				endcase
			end

		//-- J-instructions
		7'b1101111: //jal
			begin
				$display("PC=%h %s Instruction | expected x%0d=%0h, actual is %0h" , 
						  PC_tb , "JAL " , rd_reg , rd_value , RISCV_DUT.datapath.Result) ;
			end

		//-- S-instructions
		7'b0100011: //sw
			begin
				rd_reg = Instr_tb[24:20] ;

				case (Instr_tb[14:12])
				3'b010:
					begin
						$display("PC=%h %s Instruction | expected x%0d=%0d, actual is %0d" , 
								  PC_tb , "SW  " , rd_reg , rd_value , RISCV_DUT.datapath.RD2) ;
					end
				endcase			
			end
		endcase
	end