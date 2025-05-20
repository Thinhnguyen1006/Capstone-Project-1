module extend_data (
	input logic [15:0] init_data,
	input logic [1:0] ext_data_val,
	output logic [31:0] extended_data
);

always_comb begin
	case (ext_data_val)
		2'b00:	extended_data = {16'b0, init_data[15:0]};						//Zero-Extend 15-bit init-data
		2'b01:	extended_data = {24'b0, init_data[7:0]};						//Zero-Extend 8-bit init-data
		2'b10:	extended_data = {{16{init_data[15]}}, init_data[15:0]};	//Sign-Extend 15-bit init-data
		2'b11:	extended_data = {{24{init_data[7]}}, init_data[7:0]};		//Sign-Extend 8-bit init-data
	endcase
end

endmodule : extend_data
