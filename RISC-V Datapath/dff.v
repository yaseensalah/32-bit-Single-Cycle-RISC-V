module dff (
	input    wire  [31:0]	i_D     ,
	input    wire 		    i_CLK	,
	input    wire 		    i_Reset ,
	output   reg   [31:0]	o_Q	 
	);

always @(posedge i_CLK or posedge i_Reset) 
	begin
		if (i_Reset) 
			begin
				o_Q <= 32'b0 ;
			end
		else
			begin
				o_Q <= i_D ;
			end
	end

endmodule