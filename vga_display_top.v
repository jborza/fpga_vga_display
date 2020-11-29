module vga_display_top(input clk, 
	output vga_h_sync, 
	output vga_v_sync, 
	output [2:0] vga_rgb
);

wire in_display_area;
wire [9:0] pixel_x;
wire [8:0] pixel_y;

//memory connections
wire [16:0] read_address;
wire ram_out;
reg [16:0] write_address;
reg ram_in;
reg we;


//25 mhz pixel clock
reg pixel_tick;


hvsync_generator syncgen(.clk(pixel_tick), 
	.vga_h_sync(vga_h_sync), 
	.vga_v_sync(vga_v_sync),
	.in_display_area(in_display_area), 
	.counter_x(pixel_x), 
	.counter_y(pixel_y));
	
ram ram(
   .clk(clk),
	.q(ram_out), 
	.d(ram_in), 
	.write_address(write_address), 
	.read_address(read_address), 
	.we(we)
);
	
pixel_generator pixgen(
	.clk(clk),
	.video_on(in_display_area),
	.pixel_x(pixel_x),
	.pixel_y(pixel_y),
	.rgb(vga_rgb),
	.address_out(read_address),
	.data_in(ram_out)
);

// 25 mhz pixel clock
always @(posedge clk)
begin
	pixel_tick <= ~pixel_tick;
end

	
endmodule