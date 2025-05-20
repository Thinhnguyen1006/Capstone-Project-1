// sr16 module is Shift Right (>>16)
module sr16 (
	input logic [31:0] in,
	input logic left,
	input logic arith,
	input logic B4,
	output logic [31:0] out
);

always @(*) begin
	case (B4)
		1'b0:	out = in;
		1'b1:	out = {{16{((~left) & arith & in[31])}}, in[31:16]};
	endcase
end

endmodule : sr16
