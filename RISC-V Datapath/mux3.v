module mux3 (
    input    wire  [31:0]  i_DataInA  ,
    input    wire  [31:0]  i_DataInB  ,
    input    wire  [31:0]  i_DataInC  ,
    input    wire  [1:0]   i_Select   ,
    output   reg   [31:0]  o_DataOut 
    );

always @(*) 
    begin
        case (i_Select)
        2'b00:
            begin
                o_DataOut = i_DataInA ;
            end
        2'b01:
            begin
                o_DataOut = i_DataInB ;
            end
        2'b10:
            begin
                o_DataOut = i_DataInC ;
            end
        default:
            begin
                o_DataOut = 32'b0 ;
            end
        endcase
    end
    
endmodule

