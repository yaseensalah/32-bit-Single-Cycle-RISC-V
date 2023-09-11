`timescale 1ns / 1ps

module riscv_tb ();

reg	 		 CLK_tb       ;
reg	 		 Reset_tb 	  ;
wire [31:0]	 Instr_tb	  ;
wire [31:0]	 ReadData_tb  ;
wire [31:0]	 PC_tb		  ;
wire [31:0]	 ALUResult_tb ;
wire         MemWrite_tb  ;
wire [31:0]	 WriteData_tb ;

parameter CLK_PERIOD = 1 ; // 1 GHz Clk

riscv_top RISCV_DUT (
	.i_CLK		 (CLK_tb)       ,
	.i_Reset	 (Reset_tb)     ,
	.i_Instr	 (Instr_tb)     ,
	.i_ReadData  (ReadData_tb)  ,
	.o_PC	     (PC_tb)        ,
	.o_ALUResult (ALUResult_tb) ,
	.o_MemWrite  (MemWrite_tb)  ,
	.o_WriteData (WriteData_tb)      
	);

instr_memory i_mem (
	.i_A  (PC_tb[9:2]) ,
	.o_RD (Instr_tb)
	);

data_memory d_mem (
	.i_CLK   (CLK_tb)            , 
	.i_Reset (Reset_tb)          , 
	.i_A     (ALUResult_tb[9:2]) ,
	.i_WE    (MemWrite_tb)       ,
	.i_WD    (WriteData_tb)      ,
	.o_RD    (ReadData_tb)
	);


`include "clk_gen.v"
`include "reset_pattern.v"
`include "monitor.v"
`include "scoreboard.v"

initial
	begin
        reset_pattern();

        wait (PC_tb == 32'h48)
            begin
            	#1
            	$display("================================Data Memory Results================================") ;
            	$display("%0d is stored successfully in data memory[96]" , RISCV_DUT.datapath.du1_regfile.register[7]) ;
            	$display("%0d is stored successfully in data memory[92]" , RISCV_DUT.datapath.du1_regfile.register[2]) ;
                $stop ;
            end
	end

endmodule
