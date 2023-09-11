/*--------------- Reset Pattern ---------------*/
task reset_pattern ();
    begin
        Reset_tb = 1'b0 ; 
        #1
        Reset_tb = 1'b1 ;
        #1
        Reset_tb = 1'b0 ;
    end
endtask