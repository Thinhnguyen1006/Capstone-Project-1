module wrapper (
	input logic [9:0] SW,	// SW[7:0] is input value to calculate fractorial, SW[9:8] select 
	input logic [2:0] KEY,	// KEY[0] is reset button, KEY[1] is in_en for write in_val into ff
	//input logic clk,
	input logic CLOCK_50,
	output logic [9:0] LEDR,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,
	output logic [31:0] out_read, Addr_io
//	output logic [31:0] Instr,
//	output logic [31:0] wd,
//	output logic [31:0] io_val_ff,
//	output logic [6:0] op,
//	output logic [2:0] funct3,
//	output logic funct7_5,
//	output logic WE
);

logic [6:0] hex0, hex1, hex2, hex3, hex4, hex5, hex6, hex7, hex_zero;

top dut (
	.clk(CLOCK_50),
	.rst_n(KEY[0]),
	.SW_Src(SW[9:8]),
	.io_val(SW[7:0]),
	.in_en(~KEY[1]),
	//.Mem_Result(out),
	.Final_Addr_DataMem(Addr_io),
	.out_read(out_read)
//	.WE_final(WE),
//	.Instruction(Instr),
//	.op(op),
//	.funct3(funct3),
//	.funct7_5(funct7_5),
//	.io_val_ff(io_val_ff),
//	.WD_temp(wd[31:0])
);

// Instance decode_hex
decode_hex dh0 (.in(out_read[3:0]), .out(hex0));
decode_hex dh1 (.in(out_read[7:4]), .out(hex1));
decode_hex dh2 (.in(out_read[11:8]), .out(hex2));
decode_hex dh3 (.in(out_read[15:12]), .out(hex3));
decode_hex dh4 (.in(out_read[19:16]), .out(hex4));
decode_hex dh5 (.in(out_read[23:20]), .out(hex5));
decode_hex dh6 (.in(out_read[27:24]), .out(hex6));
decode_hex dh7 (.in(out_read[31:28]), .out(hex7));

decode_hex zero (.in(4'b0000), .out(hex_zero));

assign LEDR[9:0] = SW[9:0];
// HEX for 24-bit low and 8-bit high
always @(*) begin
	case (KEY[2])
		1'b0:	begin
					HEX0 = hex6;
					HEX1 = hex7;
					HEX2 = hex_zero;
					HEX3 = hex_zero;
					HEX4 = hex_zero;
					HEX5 = hex_zero;
				end
		
		1'b1:	begin
					HEX0 = hex0;
					HEX1 = hex1;
					HEX2 = hex2;
					HEX3 = hex3;
					HEX4 = hex4;
					HEX5 = hex5;
				end
	endcase
end

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
		4'h6:	out = 7'b000_0010;
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
		
		
