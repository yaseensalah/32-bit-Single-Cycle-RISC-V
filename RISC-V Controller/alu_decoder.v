module alu_decoder (
	input    wire	[1:0]	i_ALUOp	     ,
	input    wire			i_op	     ,
	input    wire	[2:0]	i_funct3     ,
	input    wire			i_funct7     ,
	output   reg	[2:0]	o_ALUControl 
	);

always @(*) 
	begin
		case (i_ALUOp)
		2'b00:
			begin
				o_ALUControl = 3'b000 ; //lw,sw
			end
		2'b01:
			begin
				o_ALUControl = 3'b001 ; //beq
			end
		2'b10:
			begin
				case (i_funct3)
				3'b000:
					begin
						if ({i_op , i_funct7} == 2'b11)
							begin
								o_ALUControl = 3'b001 ; //sub
							end
						else 
							begin
								o_ALUControl = 3'b000 ; //add
							end
					end
				3'b010:
					begin
						o_ALUControl = 3'b101 ; //slt
					end
				3'b110:
					begin
						o_ALUControl = 3'b011 ; //or
					end
				3'b111:
					begin
						o_ALUControl = 3'b010 ; //and
					end
				default:
					begin
						o_ALUControl = 3'b000 ;
					end
				endcase
			end
		default:
			begin
				o_ALUControl = 3'b000 ;
			end
		endcase
	end
endmodule
