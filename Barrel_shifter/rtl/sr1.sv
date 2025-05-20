// sr1 module is a Shift Right (>>1)
module sr1 (
	input logic [31:0] in,
	input logic left,
	input logic arith,
	input logic B0,
	output logic [31:0] out
);

always @(*) begin
	case (B0)
		1'b0:	out = in;
		1'b1:	out = {((~left) & arith & in[31]), in[31:1]};
	endcase
end

endmodule : sr1
