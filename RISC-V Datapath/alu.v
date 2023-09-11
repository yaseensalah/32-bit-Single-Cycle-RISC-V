module alu (
	input    wire	signed  [31:0]	i_SrcA    	 ,
	input    wire	signed  [31:0]	i_SrcB		 ,
	input    wire	        [2:0]	i_ALUControl ,
	output   wire	        		o_Zero		 ,
	output   wire	signed  [31:0]	o_ALUResult	 
	);

reg [31:0] ALUResult ;

always @(*) 
	begin
		case (i_ALUControl)
		3'b000: //--ADD
			begin
				ALUResult = i_SrcA + i_SrcB ;
			end
		3'b001: //--SUB
			begin
				ALUResult = i_SrcA - i_SrcB ;
			end
		3'b101: //--SLT
			begin
				//for hardware optimization, instead of adding comparator logic 
				//result is 1 if A-B is negative (A less than B) and 0 if A-B is positive
				//check Figure 5.18
				ALUResult = i_SrcA - i_SrcB ;
				ALUResult = { {31{1'b0}} , ALUResult[31] } ;
			end
		3'b011: //--OR
			begin
				ALUResult =  i_SrcA | i_SrcB ;
			end
		3'b010: //--AND
			begin
				ALUResult = i_SrcA & i_SrcB ;
			end
		default:
			begin
				ALUResult = 32'b0 ;
			end
		endcase
	end

assign o_ALUResult = ALUResult ;

assign o_Zero = (ALUResult == 32'b0)? 1 : 0 ;

endmodule