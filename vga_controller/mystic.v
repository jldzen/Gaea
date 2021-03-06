/* mystic.v
 * ECE 581: Lab 5
 * 11/21/2018
 * Julian Diaz & Jase McCaleb
 *************************************************************/
module mystic (
	input [9:0] pixel_row, pixel_column,
	input vert_sync, k0, k1, k2, k3,
	output red, green, blue
);

	wire [9:0] size;
	reg [9:0] mystic_y_motion, mystic_x_motion, mystic_y_pos, mystic_x_pos;
	reg r, g, b;

	assign size = 10'd16;
  
	initial begin
		mystic_y_pos = 10'd360;
		mystic_x_pos = 10'd320;
	end

	assign red = r;
	assign green = g;
	assign blue = b;

	// define mystic graphic element pixel-wise based on relative position
	always @ (*) begin
		case (pixel_column)
			mystic_x_pos + 1:
				begin
					case (pixel_row)
						mystic_y_pos + 11:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 12:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 13:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b0;
							end
						mystic_y_pos + 14:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b0;
							end
						mystic_y_pos + 15:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b0;
							end
						default:			
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b0;
							end
					endcase
				end
			mystic_x_pos + 2:
				begin
					case (pixel_row)
						mystic_y_pos + 6: 
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 10:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 11:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 12:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 13:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b0;
							end
						mystic_y_pos + 14:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b0;
							end
						mystic_y_pos + 15:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b0;
							end
						default:			
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b0;
							end
					endcase
				end
			mystic_x_pos + 3:
				begin
					case (pixel_row)
						mystic_y_pos + 5:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 7:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 10:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 11:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 12:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 13:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b0;
							end
						mystic_y_pos + 14:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b0;
							end
						mystic_y_pos + 15:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b0;
							end
						default:			
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b0;
							end
					endcase
				end
			mystic_x_pos + 4:
				begin
					case (pixel_row)
						mystic_y_pos + 4:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 8:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 9:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 10:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 11:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 12:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						default:			
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b0;
							end
					endcase
				end
			mystic_x_pos + 5:
				begin
					case (pixel_row)
						mystic_y_pos + 3:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 7:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 8:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 9:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 10:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 11:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 12:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						default:			
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b0;
							end
					endcase
				end
			mystic_x_pos + 6:
				begin
					case (pixel_row)
						mystic_y_pos + 1:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 2:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 3:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 4:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 5:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 6:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 7:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 8:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 9:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 10:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 11:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 12:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						default:			
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b0;
							end
					endcase
				end
			mystic_x_pos + 7:
				begin
					case (pixel_row)
						mystic_y_pos:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 1:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 2:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 3:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 4:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 5:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 6:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 7:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 8:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 9:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 10:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 11:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 12:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						default:			
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b0;
							end
					endcase
				end
			mystic_x_pos + 8:
				begin
					case (pixel_row)
						mystic_y_pos:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 1:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 2:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b0;
							end
						mystic_y_pos + 3:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 7:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 8:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 9:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 10:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 11:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 12:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						default:			
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b0;
							end
					endcase
				end
			mystic_x_pos + 9:
				begin
					case (pixel_row)
						mystic_y_pos + 1:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 2:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 3:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 7:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 8:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 9:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 10:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 11:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 12:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						default:			
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b0;
							end
					endcase
				end
			mystic_x_pos + 10:
				begin
					case (pixel_row)
						mystic_y_pos + 4:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 8:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 9:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 10:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 11:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 12:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						default:			
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b0;
							end
					endcase
				end
			mystic_x_pos + 11:
				begin
					case (pixel_row)
						mystic_y_pos + 5:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 7:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 10:
							begin
								r = 1'b0;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 11:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 12:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 13:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b0;
							end
						mystic_y_pos + 14:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b0;
							end
						mystic_y_pos + 15:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b0;
							end
						default:			
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b0;
							end
					endcase
				end
			mystic_x_pos + 12:
				begin
					case (pixel_row)
						mystic_y_pos + 6: 
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 10:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b1;
							end
						mystic_y_pos + 11:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 12:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 13:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b0;
							end
						mystic_y_pos + 14:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b0;
							end
						mystic_y_pos + 15:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b0;
							end
						default:			
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b0;
							end
					endcase
				end
			mystic_x_pos + 13:
				begin
					case (pixel_row)
						mystic_y_pos + 11:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 12:
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b1;
							end
						mystic_y_pos + 13:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b0;
							end
						mystic_y_pos + 14:
							begin
								r = 1'b1;
								g = 1'b0;
								b = 1'b0;
							end
						mystic_y_pos + 15:
							begin
								r = 1'b1;
								g = 1'b1;
								b = 1'b0;
							end
						default:			
							begin
								r = 1'b0;
								g = 1'b0;
								b = 1'b0;
							end
					endcase
				end
			default:	
				begin
						r = 1'b0;
						g = 1'b0;
						b = 1'b0;
				end
		endcase
	end

  // define graphic position based on key presses
	always @ (posedge vert_sync) begin
		if (~k2) begin
			if (mystic_y_pos >= (480 - size)) 			mystic_y_motion <= 10'd0;
			else 										mystic_y_motion <= 10'd1;
		end else if (~k3) begin
			if (mystic_y_pos <= 240) 					mystic_y_motion <= 10'd0;
			else 										mystic_y_motion <= -10'd1;
		end else 										mystic_y_motion <= 10'd0;
		mystic_y_pos <= mystic_y_pos + mystic_y_motion;

		if (~k0) begin
			if (mystic_x_pos >= (640 - size)) 			mystic_x_motion <= 10'd0;
			else 										mystic_x_motion <= 10'd1;
		end else if (~k1) begin
			if (mystic_x_pos <= size) 					mystic_x_motion <= 10'd0;
			else 										mystic_x_motion <= -10'd1;
		end else 										mystic_x_motion <= 10'd0;
		mystic_x_pos <= mystic_x_pos + mystic_x_motion;
	end
  

endmodule
