module mux2_1 (
	input logic [31:0] in0,
	input logic [31:0] in1,
	input logic [0:0] sel,
	output logic [31:0] out
);

always @(*) begin
	case (sel)
		1'b0:	out = in0;
		1'b1: out = in1;
	endcase
end

endmodule : mux2_1
