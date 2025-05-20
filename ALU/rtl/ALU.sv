module ALU (
	input logic [31:0] Arg1, Arg2,
	input logic [3:0] ALU_Control,
	output logic [2:0] GES,
	output logic [31:0] ALUResult
);
// Siganl for Logic Combination Block
logic a, o, x;
logic [2:0] aox;
// Signal for sel[1:0] of mux ALUResult
logic [1:0] sel;
// Signal la[1:0] of Barrel shifter
logic[1:0] la;
// Output signal of each blocks
logic [31:0] sum;
logic cout;
logic [31:0] comb;
logic [31:0] shift_out;


// Generate aox signal
assign a = ALU_Control[2] & ALU_Control[1] & ALU_Control[0];
assign o = ALU_Control[2] & ALU_Control[1] & (~ALU_Control[0]);
assign x = ALU_Control[2] & (~ALU_Control[1]) & ALU_Control[0];
assign aox = {a, o, x};

// Generate sel[1:0] signal
assign sel[0] = ALU_Control[3] | ((~ALU_Control[2]) & ALU_Control[1]) | (ALU_Control[2] & (~ALU_Control[1]) & (~ALU_Control[0]));
assign sel[1] = ALU_Control[3] | (ALU_Control[2] & ALU_Control[1]) | (ALU_Control[2] & ALU_Control[0]);

// Generate la[1:0] signal for shiter block (la: left-arithmetic)
assign la = {~ALU_Control[1], ALU_Control[0]};


// Instance module Adder, Shifter, Logic Combination, and Comparator
KSA_top adder (.a(Arg1), .b(Arg2), .cin(ALU_Control[0]), .sum(sum), .cout(cout));
Barrel_shifter shifter (.in(Arg1), .sel(la), .B(Arg2[4:0]), .out(shift_out));
logic_comb combination (.arg1(Arg1), .arg2(Arg2), .aox(aox), .out(comb));
Comparator compare (.A(Arg1), .B(Arg2), .sign(ALU_Control[0]), .GES(GES));

// Final ALUResult
mux4_1 finalmux (.in0(sum), .in1(shift_out), .in2(comb), .in3(32'b0), .sel(sel), .out(ALUResult));

endmodule : ALU

module mux4_1 (
	input logic [31:0] in0, in1, in2, in3,
	input logic [1:0] sel,
	output logic [31:0] out
);

always_comb begin
	case (sel)
		2'b00:	out = in0;
		2'b01:	out = in1;
		2'b10:	out = in2;
		2'b11:	out = in3;
	endcase
end

endmodule : mux4_1
