module pixel_generator(
	input wire clk,
	input wire video_on,
	input wire [9:0] pixel_x,
	input wire [9:0] pixel_y,
	output reg [2:0] rgb,
	output reg [16:0] address_out,
	input wire data_in
);

localparam MAX_X = 320;
localparam MAX_Y = 240;

//convert from 640x480 to 320x240
wire [16:0] current_address = (pixel_y[9:1] * MAX_X) + pixel_x[9:1];

always @(posedge clk) begin
	if(~video_on) begin
		rgb <= 3'b000; //blank
	end else begin
		address_out <= current_address;
		rgb <= {data_in, data_in, data_in};
	end

end

endmodule