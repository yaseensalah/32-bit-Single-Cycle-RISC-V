module instr_memory (
	input    wire	[7:0]	i_A  ,
	output   wire	[31:0]	o_RD  
	);

reg [31:0] mem [255:0] ; //1KB word-addressable ROM

initial 
	begin
		$readmemh("InstructionMem.txt", mem);
	end

assign  o_RD = mem[i_A] ;

endmodule