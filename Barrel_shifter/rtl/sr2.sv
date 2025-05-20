// sr2 module is a Shift Right (>>2)
module sr2 (
	input logic [31:0] in,
	input logic left,
	input logic arith,
	input logic B1,
	output logic [31:0] out
);

always @(*) begin
	case (B1)
		1'b0:	out = in;
		1'b1:	out = {{2{((~left) & arith & in[31])}}, in[31:2]};
	endcase
end

endmodule : sr2
