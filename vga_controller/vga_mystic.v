/* vga_mystic.v
 * ECE 581: Lab 5
 * 11/21/2018
 * Julian Diaz & Buddha
 *************************************************************/
module vga_mystic (
	input clock_50, k0, k1, k2, k3,
	output [7:0] vga_red, vga_green, vga_blue,
	output video_blank, video_clock, horiz_sync, vert_sync
);

	reg [5:0] char_address;
	reg [15:0] r,l,d,u;
	wire [9:0] pixel_row, pixel_column;
	wire char_rom_output, red_data, green_data, blue_data, vga_red_int, vga_green_int, vga_blue_int;
	wire video_blank_int, video_clock_int, v_sync_int, h_sync_int;
	integer x = 3'b000;
  
	// movable graphic
	 mystic mystic_inst (
		.pixel_row(pixel_row),
		.pixel_column(pixel_column),
		.red(red_data),
		.green(green_data),
		.blue(blue_data),
		.vert_sync(v_sync_int),
		.k0(k0),
		.k1(k1),
		.k2(k2),
		.k3(k3)
	 );
	// read-only memory contatining font data for characters
	 char_rom char_rom_inst (
		.clock(video_clock_int),
		.character_address(char_address),
		.font_row(pixel_row[2:0]),
		.font_col(pixel_column[2:0]),
		.rom_mux_output(char_rom_output)
	 );
  // vga signal generator
	vga_sync vga_sync_int (
		.clock_50mhz(clock_50),
		.red(red_data),
		.green(green_data),
		.blue(blue_data),
		.red_out(vga_red_int),
		.blue_out(vga_blue_int),
		.green_out(vga_green_int),
		.horiz_sync_out(h_sync_int),
		.vert_sync_out(v_sync_int),
		.video_on(video_blank_int),
		.pixel_clock(video_clock_int),
		.pixel_row(pixel_row),
		.pixel_column(pixel_column)
	);

	assign vert_sync = v_sync_int;
	assign horiz_sync = h_sync_int;
	assign video_clock = video_clock_int;
	assign video_blank = video_blank_int;
	
	// mux the output of RGB depending on area of screen to display
	assign vga_red =	(x == 3'b001) ? {8{char_rom_output}} 	: 
						(x == 3'b010) ? {8{char_rom_output}}	:	
						(x == 3'b011) ? 8'd0					:	
						(x == 3'b100) ? 8'd0					:	
						(x == 3'b101) ? 8'd0					:	
						(x == 3'b110) ? {8{char_rom_output}} 	:	
						(x == 3'b111) ? {8{char_rom_output}} 	:	
						{8{vga_red_int}}	;
				   
	assign vga_green = 	(x == 3'b001) ? {8{char_rom_output}} 	: 
						(x == 3'b010) ? 8'd0					:
						(x == 3'b011) ? {8{char_rom_output}} 	:
						(x == 3'b100) ? 8'd0					:
						(x == 3'b101) ? {8{char_rom_output}} 	:
						(x == 3'b110) ? 8'd0					:
						(x == 3'b111) ? {8{char_rom_output}} 	:
						{8{vga_green_int}}	;
					
	assign vga_blue = 	(x == 3'b001) ? {8{char_rom_output}} 	: 
						(x == 3'b010) ? 8'd0					:
						(x == 3'b011) ? 8'd0					:
						(x == 3'b100) ? {8{char_rom_output}} 	:			
						(x == 3'b101) ? {8{char_rom_output}} 	:
						(x == 3'b110) ? {8{char_rom_output}} 	:
						(x == 3'b111) ? 8'd0					:
						{8{vga_blue_int}}	;
  
	// define relative positions of graphic from origin
	always @ (posedge vert_sync) begin
		if (~k0)	begin 
			if (r < 16'd320 || r >= 16'hfec0)  begin
				r <= r + 16'd1;
				l <= l - 16'd1;
			end else begin
				r <= r;
				l <= l;
			end
		end else if (~k1)	 begin 
			if (l < 16'd320 || l >= 16'hfec0)  begin
				l <= l + 16'd1;
				r <= r - 16'd1;
			end else begin
				r <= r;
				l <= l;
			end
		end if (~k2)	begin
			if (d < 16'd120 || d >= 16'hff88)  begin
				d <= d + 16'd1;
				u <= u - 16'd1;
			end else begin
				d <= d;
				u <= u;
			end
		end else if (~k3)	begin
			if (u < 16'd120 || u >= 16'hff88)  begin
				u <= u + 16'd1;
				d <= d - 16'd1;
			end else begin
				d <= d;
				u <= u;
			end
		end
	end
  
	// combination logic for printing text elements
	always @ (*) begin
		x = 3'b000;
		if ((pixel_row >= 56) && (pixel_row <= 63)) begin
			x = 3'b010;
			case (pixel_column[5:3])
				3'b000:		char_address = 6'o15;
				3'b001:		char_address = 6'o31;
				3'b010:		char_address = 6'o23;
				3'b011:		char_address = 6'o24;
				3'b100:		char_address = 6'o11;
				3'b101:		char_address = 6'o03;
				default:	char_address = 6'o52;
			endcase
		end
		else if ((pixel_row >= 64) && (pixel_row <= 71)) begin
			x = 3'b011;
			case (pixel_column[5:3])
				3'b000:		char_address = 6'o15;
				3'b001:		char_address = 6'o31;
				3'b010:		char_address = 6'o23;
				3'b011:		char_address = 6'o24;
				3'b100:		char_address = 6'o11;
				3'b101:		char_address = 6'o03;	
				default:	char_address = 6'o52;
			endcase
		end 
		
		else if ((pixel_row >= 72) && (pixel_row <= 79) )begin
			x = 3'b100;
			case (pixel_column[5:3])
				3'b000:		char_address = 6'o15;
				3'b001:		char_address = 6'o31;
				3'b010:		char_address = 6'o23;
				3'b011:		char_address = 6'o24;
				3'b100:		char_address = 6'o11;
				3'b101:		char_address = 6'o03;
				default:	char_address = 6'o52;	
			endcase
		end 
		
		else if ((pixel_row >= 80) && (pixel_row <= 87)) begin
			x = 3'b101;
			case (pixel_column[5:3])
				3'b000:		char_address = 6'o15;
				3'b001:		char_address = 6'o31;
				3'b010:		char_address = 6'o23;
				3'b011:		char_address = 6'o24;
				3'b100:		char_address = 6'o11;
				3'b101:		char_address = 6'o03;	
				default:	char_address = 6'o52;
			endcase
		end
		
		else if ((pixel_row >= 88) && (pixel_row <= 95)) begin
			x = 3'b110;
			case (pixel_column[5:3])
				3'b000:		char_address = 6'o15;
				3'b001:		char_address = 6'o31;
				3'b010:		char_address = 6'o23;
				3'b011:		char_address = 6'o24;
				3'b100:		char_address = 6'o11;
				3'b101:		char_address = 6'o03;	
				default:	char_address = 6'o52;
			endcase
		end
		
		else if ((pixel_row >= 96) && (pixel_row <= 103)) begin
			x = 3'b111;
			case (pixel_column[5:3])
				3'b000:		char_address = 6'o15;
				3'b001:		char_address = 6'o31;
				3'b010:		char_address = 6'o23;
				3'b011:		char_address = 6'o24;
				3'b100:		char_address = 6'o11;
				3'b101:		char_address = 6'o03;	
				default:	char_address = 6'o52;
			endcase
		end
		
		else if ((pixel_column >= 296) && (pixel_row >= 120) && (pixel_row <= 127)) begin
		  if (pixel_column <= 383) begin
			x = 3'b001;
			case (pixel_column[6:3])
				4'b0101: 	char_address = 6'o14;
				4'b0110: 	char_address = 6'o05;
				4'b0111:    char_address = 6'o06;
				4'b1000:	char_address = 6'o24;
				4'b1001:	char_address = 6'o40;
				4'b1010:	char_address = 6'o33;
				4'b1011:    char_address = l[15:12] + 6'b110000;
				4'b1100:    char_address = l[11:8] + 6'b110000;
				4'b1101:    char_address = l[7:4] + 6'b110000;
				4'b1110:   	char_address = l[3:0] + 6'b110000;
				4'b1111:	char_address = 6'o35;
			endcase
		  end else begin
			char_address = 6'b100000;
		  end
		end else if ((pixel_column >= 296) && (pixel_row >= 128) && (pixel_row <= 135)) begin
		  if (pixel_column <= 383) begin
			x = 3'b001;
			case (pixel_column[6:3])
				4'b0101: 	char_address = 6'o22;
				4'b0110: 	char_address = 6'o11;
				4'b0111:    char_address = 6'o07;
				4'b1000:	char_address = 6'o10;
				4'b1001:	char_address = 6'o24;
				4'b1010:	char_address = 6'o33;
				4'b1011:    char_address = r[15:12] + 6'b110000;
				4'b1100:    char_address = r[11:8] + 6'b110000;
				4'b1101:    char_address = r[7:4] + 6'b110000;
				4'b1110:   	char_address = r[3:0] + 6'b110000;
				4'b1111:	char_address = 6'o35;
			endcase
		  end else begin
			char_address = 6'b100000;
		  end
		end else if ((pixel_column >= 296) && (pixel_row >= 136) && (pixel_row <= 143)) begin
		  if (pixel_column <= 383) begin
			x = 3'b001;
			case (pixel_column[6:3])
				4'b0101: 	char_address = 6'o25;
				4'b0110: 	char_address = 6'o20;
				4'b0111:    char_address = 6'o40;
				4'b1000:	char_address = 6'o40;
				4'b1001:	char_address = 6'o40;
				4'b1010:	char_address = 6'o33;
				4'b1011:    char_address = u[15:12] + 6'b110000;
				4'b1100:    char_address = u[11:8] + 6'b110000;
				4'b1101:    char_address = u[7:4] + 6'b110000;
				4'b1110:   	char_address = u[3:0] + 6'b110000;
				4'b1111:	char_address = 6'o35;
			endcase
		  end else begin
			char_address = 6'b100000;
		  end
		end else if ((pixel_column >= 296) && (pixel_row >= 144) && (pixel_row <= 151)) begin
		  if (pixel_column <= 383) begin
			x = 3'b001;
			case (pixel_column[6:3])
				4'b0101: 	char_address = 6'o04;
				4'b0110: 	char_address = 6'o17;
				4'b0111:    char_address = 6'o27;
				4'b1000:	char_address = 6'o16;
				4'b1001:	char_address = 6'o40;
				4'b1010:	char_address = 6'o33;
				4'b1011:    char_address = d[15:12] + 6'b110000;
				4'b1100:    char_address = d[11:8] + 6'b110000;
				4'b1101:    char_address = d[7:4] + 6'b110000;
				4'b1110:   	char_address = d[3:0] + 6'b110000;
				4'b1111:	char_address = 6'o35;
			endcase
		  end else begin
			char_address = 6'b100000;
		  end
		end else begin
		  char_address = 6'b100000;
		end
	end

endmodule
