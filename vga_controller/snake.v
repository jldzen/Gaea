/* snake.v
 * ECE 581: Project2
 * 12/07/2018
 * Julian Diaz & Jase McCaleb
 *************************************************************/

 module snake (
	input [9:0] pixel_row, pixel_column, 
	input vert_sync, clk50, k0, k1, k2, k3, reset, pause, pixel_clock,
	output red, green, blue
);
	
	reg [18:0] wraddress, r_pause;
	reg [8:0] snake_y_motion, snake_y_pos, apple_y_pos, rnd_row;
	reg [9:0] size, rnd_col, snake_x_motion, snake_x_pos, apple_x_pos; 
	wire [18:0] snake_pos, rdaddress;
	reg [1:0] direction, prev_dir;
	reg freeze, hv_, a, data_w, wren, freeze_init, vs;
	wire data_r;
	
	 snake_ram	snake_ram_inst (
		.clock (pixel_clock),
		.data (data_w),
		.rdaddress (rdaddress),
		.wraddress (wraddress),
		.wren (wren),
		.q (data_r)
	);
	
	assign red = (reset && a) ? 1'b1 : 1'b0;
	assign green = (reset && ~a) ? data_r : 1'b0; 
	assign blue = ((pixel_column <= 10'd10) || (pixel_column >= 10'd630) || (pixel_row <= 10'd10) || (pixel_row >= 10'd470)) ? 1'b1 : 1'b0;
	assign snake_pos = snake_x_pos + (snake_y_pos * 640);
	assign rdaddress = (vert_sync) ? (pixel_column + (pixel_row * 640)) : r_pause;	
	//assign rdaddress = (vert_sync) ? (pixel_column * (pixel_row + 1)) : 18'd0;
	
	// define snake or apples graphic elements pixel-wise based on relative position
	always @ (*) begin
		if (~reset) 	a = 1'b0;
		else if ((apple_x_pos <= (pixel_column + 10'd8)) && (apple_x_pos >= pixel_column) && (apple_y_pos <= (pixel_row + 10'd8)) && ((apple_y_pos) >= pixel_row))
						a = 1'b1;		
		else 			a = 1'b0;
		
	end
	
	always @(posedge pixel_clock) begin
		if (rnd_col >= 10'd640) rnd_col = 10'd8;
		else rnd_col = rnd_col + 1;
		
		if (rnd_row >= 10'd480) rnd_row = 10'd8;
		else rnd_row = rnd_row + 1;
		
		if (~reset) begin
			wren <= 1'b1;
			data_w <= 1'b0;			
			if (wraddress < 19'd307200)
				wraddress <= wraddress + 1;
			else
				wraddress <= 19'd0;
		end else if ((pixel_row >= 10'd480) && (pixel_row < 10'd489) && ~freeze)	begin
			
			wren <= 1'b1;
			data_w <= 1'b1;
			
			if (~hv_) begin 
				if (prev_dir != 2'b11) begin
					if ((wraddress >= (snake_pos - 10)) && (wraddress < snake_pos))			// L->V 	
						wraddress <= wraddress - 1;	
					else wraddress <= snake_pos - 1;
				end else if (prev_dir != 2'b10)	begin
					if ((wraddress <= (snake_pos + 10)) && (wraddress > snake_pos))			// R->V	
						wraddress <= wraddress + 1;
					else wraddress <= snake_pos + 1;
				end
			end else if (hv_)	begin
				if (prev_dir != 2'b01)	begin
					if ((wraddress > (snake_pos - 6400))  && (wraddress < snake_pos))		// D->H
						wraddress <= wraddress - 18'd640;
					else wraddress <= snake_pos - 18'd640;
				end else if (prev_dir != 2'b00)	begin 
					if ((wraddress < (snake_pos + 6400)) && (wraddress > snake_pos))		// U->H
						wraddress <= wraddress + 18'd640;
					else wraddress <= snake_pos + 18'd640;
				end
			end
		end else	begin
				wren <= 1'b0;
				wraddress <= snake_pos;
		end
	end
	
    // define graphics positions based on key presses
	always @ (posedge vert_sync) begin
		if (~reset) begin
			snake_y_pos <= 9'd240;
			snake_x_pos <= 10'd11;
			snake_x_motion <= 10'd1;
			snake_y_motion <= 9'd0;
			apple_x_pos <= rnd_col;
			apple_y_pos <= rnd_row;
			size <= 10'd40;
			hv_ <= 1'b1;
			freeze <= 1'b0;
			direction <= 2'b11;
			prev_dir <= 2'b11;
			r_pause <= 19'd0;
			freeze_init <= 1'b0;
		end else if (~freeze && ~pause) begin
			prev_dir <= direction;
			if (~hv_) begin
				if (~k2 && k1 && k0) begin					// V->L
					snake_y_motion <= 9'd0; 
					snake_x_motion <= -10'd1;
					direction <= 2'b10; // left
					hv_ <= 1'b1;
				end else if (~k3 && k1 && k0) begin         // V->R
					snake_y_motion <= 9'd0;
					snake_x_motion <= 10'd1;
					hv_ <= 1'b1;
					direction <= 2'b11; // right
				end
			end	else begin							
				if (~k0 && k2 && k3) begin					// H->U
					snake_y_motion <= -9'd1;
					snake_x_motion <= 10'd0;
					hv_ <= 1'b0;
					direction <= 2'b01; // up
				end else if (~k1 && k2 && k3) begin			// H->D
					snake_y_motion <= 9'd1;
					snake_x_motion <= 10'd0;
					hv_ <= 1'b0;
					direction <= 2'b00; // down
				end
			end
			
			snake_y_pos <= snake_y_pos + snake_y_motion;
			snake_x_pos <= snake_x_pos + snake_x_motion;
			
			if (direction == 2'b00) 		r_pause <= snake_pos + 640;
			else if (direction == 2'b01) 	r_pause <= snake_pos - 640;
			else if (direction == 2'b10)	r_pause <= snake_pos - 1;
			else 							r_pause <= snake_pos + 1;
		
			if (data_r) 	freeze_init <= 1'b1;
			else freeze_init <= 1'b0;
			
			if (pause) begin
				snake_x_motion <= 10'd0;
				snake_y_motion <= 9'd0;
			end
			if (snake_x_pos < 10'd11 || snake_x_pos >= 10'd638) 	begin
				snake_x_motion <= 10'd0;
				freeze <= 1'b1;
			end
			if (snake_y_pos < 9'd5 || snake_y_pos >= 9'd475) 	begin
				snake_y_motion <= 9'd0;
				freeze <= 1'b1;
			end
			
			if ((snake_x_pos >= (apple_x_pos - 10'd10)) && (snake_x_pos <= (apple_x_pos + 10'd10)) && (snake_y_pos >= (apple_y_pos - 10'd10)) && (snake_y_pos <= (apple_y_pos + 10'd10)))	begin
				apple_x_pos <= rnd_col;
				apple_y_pos <= rnd_row;
				size <= size + 10'd10;
			end
			if (~freeze) freeze <= freeze_init;
		end
	end
	
endmodule
