module mux2 (
    input    wire  [31:0]  i_DataInA  ,
    input    wire  [31:0]  i_DataInB  ,
    input    wire          i_Select   ,
    output   reg   [31:0]  o_DataOut 
    );

always @(*) 
    begin
        case (i_Select)
        1'b0:
            begin
                o_DataOut = i_DataInA ;
            end
        1'b1:
            begin
                o_DataOut = i_DataInB ;
            end
        default:
            begin
                o_DataOut = 32'b0 ;
            end
        endcase
    end
    
endmodule

