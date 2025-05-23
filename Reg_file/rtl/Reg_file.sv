module Reg_file (
	input logic clk, rst_n,
	input logic WE3,
	input logic [4:0] A1, A2, A3,
	input logic [31:0] WD3,
	output logic [31:0] RD1, RD2
);

logic [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15, R16, R17, R18, R19, R20, R21, R22, R23, R24, R25, R26, R27, R28, R29, R30, R31;
logic [31:0] en;

decoder_wd3 dut0 (.A(A3), .WE3(WE3), .en(en));

reg0_32bit r0 (.RD(R0));
reg_32bit r1 (.clk(clk), .rst_n(rst_n), .en(en[1]), .d(WD3), .q(R1));
reg_32bit r2 (.clk(clk), .rst_n(rst_n), .en(en[2]), .d(WD3), .q(R2));
reg_32bit r3 (.clk(clk), .rst_n(rst_n), .en(en[3]), .d(WD3), .q(R3));
reg_32bit r4 (.clk(clk), .rst_n(rst_n), .en(en[4]), .d(WD3), .q(R4));
reg_32bit r5 (.clk(clk), .rst_n(rst_n), .en(en[5]), .d(WD3), .q(R5));
reg_32bit r6 (.clk(clk), .rst_n(rst_n), .en(en[6]), .d(WD3), .q(R6));
reg_32bit r7 (.clk(clk), .rst_n(rst_n), .en(en[7]), .d(WD3), .q(R7));
reg_32bit r8 (.clk(clk), .rst_n(rst_n), .en(en[8]), .d(WD3), .q(R8));
reg_32bit r9 (.clk(clk), .rst_n(rst_n), .en(en[9]), .d(WD3), .q(R9));
reg_32bit r10 (.clk(clk), .rst_n(rst_n), .en(en[10]), .d(WD3), .q(R10));
reg_32bit r11 (.clk(clk), .rst_n(rst_n), .en(en[11]), .d(WD3), .q(R11));
reg_32bit r12 (.clk(clk), .rst_n(rst_n), .en(en[12]), .d(WD3), .q(R12));
reg_32bit r13 (.clk(clk), .rst_n(rst_n), .en(en[13]), .d(WD3), .q(R13));
reg_32bit r14 (.clk(clk), .rst_n(rst_n), .en(en[14]), .d(WD3), .q(R14));
reg_32bit r15 (.clk(clk), .rst_n(rst_n), .en(en[15]), .d(WD3), .q(R15));
reg_32bit r16 (.clk(clk), .rst_n(rst_n), .en(en[16]), .d(WD3), .q(R16));
reg_32bit r17 (.clk(clk), .rst_n(rst_n), .en(en[17]), .d(WD3), .q(R17));
reg_32bit r18 (.clk(clk), .rst_n(rst_n), .en(en[18]), .d(WD3), .q(R18));
reg_32bit r19 (.clk(clk), .rst_n(rst_n), .en(en[19]), .d(WD3), .q(R19));
reg_32bit r20 (.clk(clk), .rst_n(rst_n), .en(en[20]), .d(WD3), .q(R20));
reg_32bit r21 (.clk(clk), .rst_n(rst_n), .en(en[21]), .d(WD3), .q(R21));
reg_32bit r22 (.clk(clk), .rst_n(rst_n), .en(en[22]), .d(WD3), .q(R22));
reg_32bit r23 (.clk(clk), .rst_n(rst_n), .en(en[23]), .d(WD3), .q(R23));
reg_32bit r24 (.clk(clk), .rst_n(rst_n), .en(en[24]), .d(WD3), .q(R24));
reg_32bit r25 (.clk(clk), .rst_n(rst_n), .en(en[25]), .d(WD3), .q(R25));
reg_32bit r26 (.clk(clk), .rst_n(rst_n), .en(en[26]), .d(WD3), .q(R26));
reg_32bit r27 (.clk(clk), .rst_n(rst_n), .en(en[27]), .d(WD3), .q(R27));
reg_32bit r28 (.clk(clk), .rst_n(rst_n), .en(en[28]), .d(WD3), .q(R28));
reg_32bit r29 (.clk(clk), .rst_n(rst_n), .en(en[29]), .d(WD3), .q(R29));
reg_32bit r30 (.clk(clk), .rst_n(rst_n), .en(en[30]), .d(WD3), .q(R30));
reg_32bit r31 (.clk(clk), .rst_n(rst_n), .en(en[31]), .d(WD3), .q(R31));

// Mux for RD1
mux32_1 rd1 (
	.A(A1),
	.in0(R0),
	.in1(R1),
	.in2(R2),
	.in3(R3),
	.in4(R4),
	.in5(R5),
	.in6(R6),
	.in7(R7),
	.in8(R8),
	.in9(R9),
	.in10(R10),
	.in11(R11),
	.in12(R12),
	.in13(R13),
	.in14(R14),
	.in15(R15),
	.in16(R16),
	.in17(R17),
	.in18(R18),
	.in19(R19),
	.in20(R20),
	.in21(R21),
	.in22(R22),
	.in23(R23),
	.in24(R24),
	.in25(R25),
	.in26(R26),
	.in27(R27),
	.in28(R28),
	.in29(R29),
	.in30(R30),
	.in31(R31),
	.out(RD1)
);
// Mux for RD2
mux32_1 rd2 (
	.A(A2),
	.in0(R0),
	.in1(R1),
	.in2(R2),
	.in3(R3),
	.in4(R4),
	.in5(R5),
	.in6(R6),
	.in7(R7),
	.in8(R8),
	.in9(R9),
	.in10(R10),
	.in11(R11),
	.in12(R12),
	.in13(R13),
	.in14(R14),
	.in15(R15),
	.in16(R16),
	.in17(R17),
	.in18(R18),
	.in19(R19),
	.in20(R20),
	.in21(R21),
	.in22(R22),
	.in23(R23),
	.in24(R24),
	.in25(R25),
	.in26(R26),
	.in27(R27),
	.in28(R28),
	.in29(R29),
	.in30(R30),
	.in31(R31),
	.out(RD2)
);


endmodule : Reg_file



module mux32_1 (
	input logic [4:0] A,
	input logic [31:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31,
	output logic [31:0] out
);
always @(*) begin
	case (A)
		5'h00:	out = in0;
		5'h01:	out = in1;
		5'h02:	out = in2;
		5'h03:	out = in3;
		5'h04:	out = in4;
		5'h05:	out = in5;
		5'h06:	out = in6;
		5'h07:	out = in7;
		5'h08:	out = in8;
		5'h09:	out = in9;
		5'h0A:	out = in10;
		5'h0B:	out = in11;
		5'h0C:	out = in12;
		5'h0D:	out = in13;
		5'h0E:	out = in14;
		5'h0F:	out = in15;
		5'h10:	out = in16;
		5'h11:	out = in17;
		5'h12:	out = in18;
		5'h13:	out = in19;
		5'h14:	out = in20;
		5'h15:	out = in21;
		5'h16:	out = in22;
		5'h17:	out = in23;
		5'h18:	out = in24;
		5'h19:	out = in25;
		5'h1A:	out = in26;
		5'h1B:	out = in27;
		5'h1C:	out = in28;
		5'h1D:	out = in29;
		5'h1E:	out = in30;
		5'h1F:	out = in31;
	endcase
end
endmodule : mux32_1


// Module Decoder for enable of WD3
module decoder_wd3 (
	input logic [4:0] A,
	input logic WE3,
	output logic [31:0] en
);

always @(*) begin
	case (A)
		5'h00:	en = 32'h0000_0001 & {32{WE3}};
		5'h01:	en = 32'h0000_0002 & {32{WE3}};
		5'h02:	en = 32'h0000_0004 & {32{WE3}};
		5'h03:	en = 32'h0000_0008 & {32{WE3}};
		5'h04:	en = 32'h0000_0010 & {32{WE3}};
		5'h05:	en = 32'h0000_0020 & {32{WE3}};
		5'h06:	en = 32'h0000_0040 & {32{WE3}};
		5'h07:	en = 32'h0000_0080 & {32{WE3}};
		5'h08:	en = 32'h0000_0100 & {32{WE3}};
		5'h09:	en = 32'h0000_0200 & {32{WE3}};
		5'h0A:	en = 32'h0000_0400 & {32{WE3}};
		5'h0B:	en = 32'h0000_0800 & {32{WE3}};
		5'h0C:	en = 32'h0000_1000 & {32{WE3}};
		5'h0D:	en = 32'h0000_2000 & {32{WE3}};
		5'h0E:	en = 32'h0000_4000 & {32{WE3}};
		5'h0F:	en = 32'h0000_8000 & {32{WE3}};
		5'h10:	en = 32'h0001_0000 & {32{WE3}};
		5'h11:	en = 32'h0002_0001 & {32{WE3}};
		5'h12:	en = 32'h0004_0001 & {32{WE3}};
		5'h13:	en = 32'h0008_0001 & {32{WE3}};
		5'h14:	en = 32'h0010_0001 & {32{WE3}};
		5'h15:	en = 32'h0020_0001 & {32{WE3}};
		5'h16:	en = 32'h0040_0001 & {32{WE3}};
		5'h17:	en = 32'h0080_0001 & {32{WE3}};
		5'h18:	en = 32'h0100_0001 & {32{WE3}};
		5'h19:	en = 32'h0200_0001 & {32{WE3}};
		5'h1A:	en = 32'h0400_0001 & {32{WE3}};
		5'h1B:	en = 32'h0800_0001 & {32{WE3}};
		5'h1C:	en = 32'h1000_0001 & {32{WE3}};
		5'h1D:	en = 32'h2000_0001 & {32{WE3}};
		5'h1E:	en = 32'h4000_0001 & {32{WE3}};
		5'h1F:	en = 32'h8000_0001 & {32{WE3}};
	endcase
end

endmodule : decoder_wd3
