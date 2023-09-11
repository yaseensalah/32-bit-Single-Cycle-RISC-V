reg [31:0] rd_value ; // Destination Register Value

always @(*) 
	begin
		case (PC_tb)
		32'h00: // x2 = 5
			begin
				rd_value = 32'd5 ;
			end
		32'h04: //  x3 = 12
			begin
				rd_value = 32'd12 ;
			end
		32'h08: //  x7 = (12 - 9) = 3
			begin
				rd_value = 32'd3 ;
			end
		32'h0C: //  x4 = (3 OR 5) = 7
			begin
				rd_value = 32'd7 ;
			end
		32'h10: //  x5 = (12 AND 7) = 4
			begin
				rd_value = 32'd4 ;
			end
		32'h14: //  x5 = 4 + 7 = 11
			begin
				rd_value = 32'd11 ;
			end
		32'h18: //  beq x5, x7, end (NO)
			begin
				rd_value = rd_reg ;
			end
		32'h1C: //  beq x4, x0, around (NO)
			begin
				rd_value = rd_reg ;
			end
		32'h20: //  addi x5, x0, 0
			begin
				rd_value = 32'd0 ;
			end
		32'h24: //  add x7, x4, x5  <-around
			begin
				rd_value = 32'd7 ;
			end
		32'h28: //  sub x7, x7, x2 
			begin
				rd_value = 32'd2 ;
			end
		32'h2C: //  sw x7, 84(x3) 
			begin
				rd_value = 32'd2 ;
			end
		32'h30: //  lw x2, 96(x0)  
			begin
				rd_value = 32'd2 ;
			end
		32'h34: //  add x9, x2, x5
			begin
				rd_value = 32'd2 ;
			end
		32'h38: //  jal x3, end 
			begin
				rd_value = 32'h3C ;
			end
		32'h3C: //  addi x2, x0, 1 
			begin
				rd_value = 32'd1 ;
			end
		32'h40: //  add x2, x2, x9  <-end
			begin
				rd_value = 32'd4 ;
			end
		32'h44: //  sw x2, 0x20(x3)
			begin
				rd_value = 32'd4 ;
			end
		32'h48: //  beq x2, x2, done  <-done
			begin
				rd_value = rd_reg ;
			end
		endcase
	end