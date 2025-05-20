module logic_comb (
	input logic [31:0] arg1,	//agr1 is value of rs1
	input logic [31:0] arg2,	//agr2 is value of rs2 or Sign_Ext[imm]
	input logic [2:0] aox,		// and - or - xor
	output logic [31:0] out
);

always_comb begin
	case (aox)
		3'b001:	out = arg1 ^ arg2;
		3'b010:	out = arg1 | arg2;
		3'b100:	out = arg1 & arg2;
		default:	out = 32'h0000_0000;
	endcase
end

endmodule : logic_comb