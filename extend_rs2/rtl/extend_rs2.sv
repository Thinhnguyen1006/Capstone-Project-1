module extend_rs2 (
	input logic [31:0] rd2,
	input logic [1:0] Ext_rs2_Src,
	output logic [31:0] out
);

always_comb begin
	case (Ext_rs2_Src)
		2'b00:	out = rd2;									// SW instruciton store 32-bit
		2'b01:	out = {{16{rd2[15]}}, rd2[15:0]};	// SH instruciton store 16-bit
		2'b10:	out = {{24{rd2[7]}}, rd2[7:0]};		//SB instruction store 8-bit
		default:	out = 32'h0000_0000;
	endcase
end

endmodule : extend_rs2
