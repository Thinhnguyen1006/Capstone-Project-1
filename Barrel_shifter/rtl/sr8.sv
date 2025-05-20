// sr8 module is Shift Right (>>8))
module sr8 (
	input logic [31:0] in,
	input logic left,
	input logic arith,
	input logic B3,
	output logic [31:0] out	
);

always @(*) begin
	case (B3)
		1'b0:	out = in;
		1'b1:	out = {{8{((~left) & arith & in[31])}}, in[31:8]};
	endcase
end

endmodule : sr8
