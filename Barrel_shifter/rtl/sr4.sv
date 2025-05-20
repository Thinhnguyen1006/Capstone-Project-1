// sr4 module is a Shift Right (>>4)
module sr4 (
	input logic [31:0] in,
	input logic left,
	input logic arith,
	input logic B2,
	output logic [31:0] out
);

always @(*) begin
	case (B2)
		1'b0:	out = in;
		1'b1:	out = {{4{((~left) & arith & in[31])}}, in[31:4]};
	endcase
end

endmodule : sr4
