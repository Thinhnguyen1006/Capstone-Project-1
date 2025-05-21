module InstructionMem (
	input [31:0] A,
	output [31:0] RD
);
 // Memory array 256 entries of 32-bit words
reg [31:0] mem [0:255] = '{default: 32'h0000_0000};
 
 // Initialize memory from file
initial begin
		$readmemh("INSTRUCTIONS.txt", mem);
end

// RD changes as A changes
assign RD = mem[A[31:0]];

endmodule : InstructionMem
