//-----Clock Generation
initial 
	begin
        CLK_tb  = 1'b1 ;     
        forever      
        #(CLK_PERIOD*0.5) CLK_tb = ~CLK_tb ;  		
	end