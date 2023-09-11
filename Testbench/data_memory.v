module data_memory (
	input    wire			i_CLK   ,
	input    wire			i_Reset ,
	input    wire	[7:0]	i_A     ,
	input    wire	     	i_WE    ,
	input    wire	[31:0]	i_WD    ,
	output   wire	[31:0]	o_RD  
	);

reg [31:0] mem [255:0] ; //1KB word-addressable RAM
integer i ;

always @(posedge i_CLK or posedge i_Reset) 
	begin
		if (i_Reset)
			begin
				for (i=0 ; i<256 ; i=i+1)
					begin
						mem[i] <= 32'b0 ;
					end
			end
		else if (i_WE) 
			begin
				mem[i_A] <= i_WD ;
			end
	end

assign  o_RD = mem[i_A] ;

endmodule