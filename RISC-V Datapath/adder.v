module adder (
	input    wire	signed  [31:0]	i_SrcA    	  ,
	input    wire	signed  [31:0]	i_SrcB		  ,
	output   wire	signed  [31:0]	o_AdderResult	 
	);

assign o_AdderResult = i_SrcA + i_SrcB ;

endmodule