module DataMem (
	input logic clk,
	input logic WE,
	input logic [31:0] A,
	input logic [31:0] WD,
	output logic [31:0] RD
);

reg [31:0] mem [0:255] = '{default: 32'h0000_0000};

always @(posedge clk) begin
	if (WE) begin
		mem[A[31:0]] <= WD;
	end
end

assign RD = mem[A[31:0]];

endmodule : DataMem
