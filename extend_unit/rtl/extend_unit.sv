module extend_unit (
	input logic [31:7] in,
	input logic [2:0] ImmSrc,
	output logic [31:0] out
);

always_comb begin
	case (ImmSrc)
		3'b000:	out = {{20{in[31]}}, in[31:20]};
		3'b001:	out = {{20{in[31]}}, in[31:25], in[11:7]};
		3'b010:	out = {{20{in[31]}}, in[7], in[30:25], in[11:8], 1'b0};
		3'b011:	out = {{12{in[31]}}, in[19:12], in[20], in[30:21], 1'b0};
		3'b100:	out = {in[31:12], 12'h000};
		3'b101:	out = {27'b0, in[24:20]};
		default:	out = 32'h0000_0000;
	endcase
end

endmodule : extend_unit