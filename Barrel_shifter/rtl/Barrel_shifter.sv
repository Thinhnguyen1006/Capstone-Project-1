//	Barrel Shifter:
// + Logical shift right & left
// + Arithmetic shift right

module Barrel_shifter (
	input logic [31:0] in,
	input logic [1:0] sel,	// sel[1]: 1=left or 0=right; sel[0]: 1=arithmetic or 0=logical
	input logic [4:0] B,		// number of shifted bits
	output logic [31:0] out
);

logic [31:0] shift_out;

logic [31:0] out1, out2, out4, out8, out16;	// Output of srlx module
logic [31:0] out_mux0, out_mux1, out_mux2, out_mux3, out_mux4;	// Output of mux
logic [31:0] out_reverse;

reverse reversal_in (.in(in[31:0]), .left(sel[1]), .out(out_reverse[31:0]));

sr1 shift1 (.in(out_reverse), .left(sel[1]), .arith(sel[0]), .B0(B[0]), .out(out1));
mux2_1 mux0 (.in0(out_reverse), .in1(out1), .sel(B[0]), .out(out_mux0));

sr2 shift2 (.in(out_mux0), .left(sel[1]), .arith(sel[0]), .B1(B[1]), .out(out2));
mux2_1 mux1 (.in0(out_mux0), .in1(out2), .sel(B[1]), .out(out_mux1));

sr4 shift4 (.in(out_mux1), .left(sel[1]), .arith(sel[0]), .B2(B[2]), .out(out4));
mux2_1 mux2 (.in0(out_mux1), .in1(out4), .sel(B[2]), .out(out_mux2));

sr8 shift8 (.in(out_mux2), .left(sel[1]), .arith(sel[0]), .B3(B[3]), .out(out8));
mux2_1 mux3 (.in0(out_mux2), .in1(out8), .sel(B[3]), .out(out_mux3));

sr16 shift16 (.in(out_mux3), .left(sel[1]), .arith(sel[0]), .B4(B[4]), .out(out16));
mux2_1 mux4 (.in0(out_mux3), .in1(out16), .sel(B[4]), .out(out_mux4));

reverse reversal_out (.in(out_mux4), .left(sel[1]), .out(shift_out));

assign out = shift_out;

endmodule : Barrel_shifter
