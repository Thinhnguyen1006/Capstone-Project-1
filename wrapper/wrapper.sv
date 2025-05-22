module wrapper (
	input logic [8:0] SW,	// SW[7:0] is input address for DataMem, SW[8] sw_Src
	input logic [0:0] KEY,	// KEY[0] is rst_n
	input logic clk,// CLOCK_50,
	output logic [8:0] LEDR,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
	output logic [31:0] out_read, Addr_io
);

logic [6:0] hex0, hex1, hex2, hex3, hex4, hex5;

top dut (
	.clk(clk),
	.rst_n(KEY[0]),
	.SW_Src(SW[8]),
	.io(SW[7:0]),
	//.Mem_Result(out),
	.Final_Addr_DataMem(Addr_io),
	.out_read(out_read)
);

// Instance decode_hex
decode_hex dh0 (.in(out_read[3:0]), .out(hex0));
decode_hex dh1 (.in(out_read[7:4]), .out(hex1));
decode_hex dh2 (.in(out_read[11:8]), .out(hex2));
decode_hex dh3 (.in(out_read[15:12]), .out(hex3));
decode_hex dh4 (.in(out_read[19:16]), .out(hex4));
decode_hex dh5 (.in(out_read[23:20]), .out(hex5));

assign LEDR[8:0] = SW[8:0];
assign HEX0 = hex0;
assign HEX1 = hex1;
assign HEX2 = hex2;
assign HEX3 = hex3;
assign HEX4 = hex4;
assign HEX5 = hex5;

endmodule : wrapper

module decode_hex (
	input logic [3:0] in,
	output logic [6:0] out
);

always @(*) begin
	case (in)
		4'h0:	out = 7'b100_0000;
		4'h1:	out = 7'b111_1001;
		4'h2:	out = 7'b010_0100;
		4'h3:	out = 7'b011_0000;
		4'h4:	out = 7'b001_1001;
		4'h5:	out = 7'b001_0010;
		4'h6:	out = 7'h000_0010;
		4'h7:	out = 7'b111_1000;
		4'h8:	out = 7'b000_0000;
		4'h9:	out = 7'b001_0000;
		4'hA:	out = 7'b000_1000;
		4'hB:	out = 7'b000_0011;
		4'hC:	out = 7'b100_0110;
		4'hD:	out = 7'b010_0001;
		4'hE:	out = 7'b000_0110;
		4'hF:	out = 7'b000_1110;
	endcase
end

endmodule : decode_hex
		
		
