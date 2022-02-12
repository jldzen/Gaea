module char_rom (
  input [5:0] character_address,
  input [2:0] font_row, font_col,
  input clock,
  output rom_mux_output
);

  parameter address_width = 9;
  parameter data_width = 8;

  wire [address_width-1:0] rom_address;
  wire [data_width-1:0] rom_data;

  assign rom_address = {character_address, font_row};

  // rom_mux_output
  assign rom_mux_output = rom_data[~font_col[2:0]];
  
  rom_block rom_block_inst (
    .address(rom_address),
    .clock(clock),
    .q(rom_data)
  );

endmodule
