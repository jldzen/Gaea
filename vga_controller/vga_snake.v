/* vga_snake.v
 * ECE 581: Project2
 * 12/07/2018
 * Julian Diaz & Jase McCaleb
 *************************************************************/
module vga_snake (
	input clock_50, k0, k1, k2, k3, SW0, SW1,
	output [7:0] vga_red, vga_green, vga_blue,
	output video_blank, video_clock, horiz_sync, vert_sync
);

	wire [9:0] pixel_row, pixel_column;
	wire red_data, green_data, blue_data, red_data1, green_data1, blue_data1, vga_red_int, vga_green_int, vga_blue_int;
	wire video_blank_int, video_clock_int, v_sync_int, h_sync_int;
  
	// graphics
	 snake snake_inst (
		.pixel_row(pixel_row),
		.pixel_column(pixel_column),
		.pixel_clock(video_clock_int),
		.red(red_data),
		.green(green_data),
		.blue(blue_data),
		.vert_sync(v_sync_int),
		.clk50(clock_50),
		.k0(k0),
		.k1(k1),
		.k2(k2),
		.k3(k3),
		.reset(SW0),
		.pause(SW1)
	 );
	 
//	 fun_snake snake_inst1 (
//		.pixel_row(pixel_row),
//		.pixel_column(pixel_column),
//		.pixel_clock(video_clock_int),
//		.red(red_data1),
//		.green(green_data1),
//		.blue(blue_data1),
//		.vert_sync(v_sync_int),
//		.clk50(clock_50),
//		.k0(k0),
//		.k1(k1),
//		.k2(k2),
//		.k3(k3),
//		.reset(SW0),
//		.pause(SW1)
//	 );
	 
    // vga signal generator
	vga_sync vga_sync_int (
		.clock_50mhz(clock_50),
		.red(red_data || red_data1),
		.green(green_data || green_data1),
		.blue(blue_data || blue_data1),
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
	
	assign vga_red   = {8{vga_red_int}};			   
	assign vga_green = {8{vga_green_int}};
	assign vga_blue  = {8{vga_blue_int}}	;

endmodule
