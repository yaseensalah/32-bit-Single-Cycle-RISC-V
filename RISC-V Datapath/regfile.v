module regfile (
	input    wire			i_CLK   ,
	input    wire			i_Reset ,
	input    wire	[4:0]	i_A1	,
	input    wire	[4:0]	i_A2	,
	input    wire	[4:0]	i_A3	,
	input    wire			i_WE3	,
	input    wire	[31:0]	i_WD3	,
	output   wire	[31:0]	o_RD1	,
	output   wire	[31:0]	o_RD2  
	);

reg [31:0] register [31:0] ;
integer i ;

always @(posedge i_CLK or posedge i_Reset) 
	begin
		if (i_Reset)
			begin
				for (i=0 ; i<32 ; i=i+1)
					begin
						register[i] <= 32'b0 ;
					end
			end
		else if (i_WE3) 
			begin
				register[i_A3] <= i_WD3 ;
			end
	end

assign  o_RD1 = (i_A1 != 5'b0)? register[i_A1] : 32'b0 ;
assign  o_RD2 = (i_A2 != 5'b0)? register[i_A2] : 32'b0 ;

endmodule