`timescale 1ns/1ps
module Control_unit_tb;
// Parameter
parameter GES_LT = 3'b001;
parameter GES_EQ = 4'b010;
parameter GES_GE = 3'b100;

   logic [6:0] op;
   logic [2:0] funct3;
   logic funct7_5;
   logic [2:0] GES;
   logic PCSrc;
   logic [1:0] Ext_rs2_Src;
   logic [1:0] ResultSrc;
   logic [1:0] Ext_Data_Val;
   logic Ext_Data_Src;
   logic [3:0] ALU_Control;
   logic ALUSrc;
   logic [2:0] ImmSrc;
   logic JALR_Src;
   logic AUIPC_Src;
   logic MemWrite;
   logic RegWrite;

   // Instance Control_unit DUT
   Control_unit dut (
	   .op(op),
	   .funct3(funct3),
	   .funct7_5(funct7_5),
	   .GES(GES),
	   .PCSrc(PCSrc),
	   .Ext_rs2_Src(Ext_rs2_Src),
	   .ResultSrc(ResultSrc),
	   .Ext_Data_Val(Ext_Data_Val),
	   .Ext_Data_Src(Ext_Data_Src),
	   .ALU_Control(ALU_Control),
	   .ALUSrc(ALUSrc),
	   .ImmSrc(ImmSrc),
	   .JALR_Src(JALR_Src),
	   .AUIPC_Src(AUIPC_Src),
	   .MemWrite(MemWrite),
	   .RegWrite(RegWrite)
	   );


   initial begin
	   $dumpfile("Control_unit_wave.vcl");
	   $dumpvars(0, Control_unit_tb);
   end

   initial begin
	   // Initial
	   op = 7'b000_0000;
	   funct3 = 3'b000;
	   funct7_5 = 1'b0;
	   #5;
   end

   initial begin	
	logic [33:0] temp0, temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15, temp16, temp17, temp18, temp19, temp20, temp21, temp22, temp23, temp24, temp25, temp26, temp27, temp28, temp29, temp30, temp31, temp32, temp33, temp34, temp35, temp36;
	
	// Test cases for 37 instructions with GES = 3'b001
	// LB
	temp0 = {7'b000_0011, 3'b000, 1'b0, GES_LT, 4'b0000, 1'b1, 3'b010, 2'b01, 1'b0, 1'b0, 1'b0, 2'b11, 1'b1, 2'b00, 1'b0, 1'b1}; 
	//temp = 34'b00_0001_1000_0000_0000_1010_0100_0111_0001;
	// LH
	temp1 = {7'b000_0011, 3'b001, 1'b0, GES_LT, 4'b0000, 1'b1, 3'b010, 2'b01, 1'b0, 1'b0, 1'b0, 2'b10, 1'b1, 2'b00, 1'b0, 1'b1};
	// LW
	temp2 = {7'b000_0011, 3'b010, 1'b0, GES_LT, 4'b0000, 1'b1, 3'b010, 2'b01, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// LBU
	temp3 = {7'b000_0011, 3'b100, 1'b0, GES_LT, 4'b0000, 1'b1, 3'b010, 2'b01, 1'b0, 1'b0, 1'b0, 2'b01, 1'b1, 2'b00, 1'b0, 1'b1};
	// LHU
	temp4 = {7'b000_0011, 3'b101, 1'b0, GES_LT, 4'b0000, 1'b1, 3'b010, 2'b01, 1'b0, 1'b0, 1'b0, 2'b00, 1'b1, 2'b00, 1'b0, 1'b1};
	// ADDI
	temp5 = {7'b001_0011, 3'b000, 1'b0, GES_LT, 4'b0000, 1'b1, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// SLLI
	temp6 = {7'b001_0011, 3'b001, 1'b0, GES_LT, 4'b0100, 1'b1, 3'b101, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// SLTI
	temp7 = {7'b001_0011, 3'b010, 1'b0, GES_LT, 4'b1001, 1'b1, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// SLTIU
	temp8 = {7'b001_0011, 3'b011, 1'b0, GES_LT, 4'b1000, 1'b1, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// XORI
	temp9 = {7'b001_0011, 3'b100, 1'b0, GES_LT, 4'b0101, 1'b1, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// SRLI
	temp10= {7'b001_0011, 3'b101, 1'b0, GES_LT, 4'b0010, 1'b1, 3'b101, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// SRAI
	temp11 = {7'b001_0011, 3'b101, 1'b1, GES_LT, 4'b0011, 1'b1, 3'b101, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// ORI
	temp12 = {7'b001_0011, 3'b110, 1'b0, GES_LT, 4'b0110, 1'b1, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// ANDI
	temp13 = {7'b001_0011, 3'b111, 1'b0, GES_LT, 4'b0111, 1'b1, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// AUIPC
	temp14 = {7'b001_0111, 3'b000, 1'b0, GES_LT, 4'b0000, 1'b0, 3'b100, 2'b00, 1'b0, 1'b0, 1'b1, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// SB
	temp15 = {7'b010_0011, 3'b000, 1'b0, GES_LT, 4'b0000, 1'b1, 3'b001, 2'b11, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b10, 1'b1, 1'b0};
	// SH
	temp16 = {7'b010_0011, 3'b001, 1'b0, GES_LT, 4'b0000, 1'b1, 3'b001, 2'b11, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b01, 1'b1, 1'b0};
	// SW
	temp17 = {7'b010_0011, 3'b010, 1'b0, GES_LT, 4'b0000, 1'b1, 3'b001, 2'b11, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b1, 1'b0};
	// ADD
	temp18 = {7'b011_0011, 3'b000, 1'b0, GES_LT, 4'b0000, 1'b0, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// SUB
	temp19 = {7'b011_0011, 3'b000, 1'b1, GES_LT, 4'b0001, 1'b0, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// SLL
	temp20 = {7'b011_0011, 3'b001, 1'b0, GES_LT, 4'b0100, 1'b0, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// SLT
	temp21 = {7'b011_0011, 3'b010, 1'b0, GES_LT, 4'b1001, 1'b0, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// SLTU
	temp22 = {7'b011_0011, 3'b011, 1'b0, GES_LT, 4'b1000, 1'b0, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// XOR
	temp23 = {7'b011_0011, 3'b100, 1'b0, GES_LT, 4'b0101, 1'b0, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// SRL
	temp24 = {7'b011_0011, 3'b101, 1'b0, GES_LT, 4'b0010, 1'b0, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// SRA
	temp25 = {7'b011_0011, 3'b101, 1'b1, GES_LT, 4'b0011, 1'b0, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// OR
	temp26 = {7'b011_0011, 3'b110, 1'b0, GES_LT, 4'b0110, 1'b0, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// AND
	temp27 = {7'b011_0011, 3'b111, 1'b0, GES_LT, 4'b0111, 1'b0, 3'b000, 2'b00, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// LUI
	temp28 = {7'b011_0111, 3'b000, 1'b0, GES_LT, 4'b0000, 1'b0, 3'b100, 2'b11, 1'b0, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};
	// JALR
	temp29 = {7'b110_1111, 3'b000, 1'b0, GES_LT, 4'b0000, 1'b0, 3'b011, 2'b10, 1'b1, 1'b0, 1'b0, 2'b00, 1'b0, 2'b00, 1'b0, 1'b1};

	// Instance task chk_ins
	chk_inst (temp0);
	chk_inst (temp1);
	chk_inst (temp2);
	chk_inst (temp3);
	chk_inst (temp4);
	chk_inst (temp5);
	chk_inst (temp6);
	chk_inst (temp7);
	chk_inst (temp8);
	chk_inst (temp9);
	chk_inst (temp10);
	chk_inst (temp11);
	chk_inst (temp12);
	chk_inst (temp13);
	chk_inst (temp14);
	chk_inst (temp15);
	chk_inst (temp16);
	chk_inst (temp17);
	chk_inst (temp18);
	chk_inst (temp19);
	chk_inst (temp20);
	chk_inst (temp21);
	chk_inst (temp22);
	chk_inst (temp23);
	chk_inst (temp24);
	chk_inst (temp25);
	chk_inst (temp26);
	chk_inst (temp27);
	chk_inst (temp28);
	chk_inst (temp29);
end

task chk_inst (
	input logic [33:0] in_temp	
	);

	logic [3:0] 	expect_ALU_Control;
	logic 		expect_ALUSrc;
	logic [2:0] 	expect_ImmSrc;
	logic [1:0] 	expect_ResultSrc;
	logic 		expect_PCSrc;
	logic 		expect_JALR_Src;
	logic 		expect_AUIPC_Src;
	logic [1:0] 	expect_Ext_Data_Val;
	logic 		expect_Ext_Data_Src;
	logic [1:0] 	expect_Ext_rs2_Src;
	logic 		expect_MemWrite;
	logic 		expect_RegWrite;

	logic [13:0] 	instr_code;

	begin
		// Input signals for DUT
		op 			= in_temp[33:27];
		funct3 			= in_temp[26:24];
		funct7_5 		= in_temp[23];
		GES 			= in_temp[22:20];

		// Seperate signal
		instr_code 		= in_temp[33:20];
		expect_ALU_Control 	= in_temp[19:16];
		expect_ALUSrc 		= in_temp[15];
		expect_ImmSrc 		= in_temp[14:12];
		expect_ResultSrc 	= in_temp[11:10];
		expect_PCSrc 		= in_temp[9];
		expect_JALR_Src 	= in_temp[8];
		expect_AUIPC_Src 	= in_temp[7];
		expect_Ext_Data_Val 	= in_temp[6:5];
		expect_Ext_Data_Src 	= in_temp[4];
		expect_Ext_rs2_Src 	= in_temp[3:2];
		expect_MemWrite 	= in_temp[1];
		expect_RegWrite 	= in_temp[0];

		#10;

		// Check epxected value
		if ((ALU_Control == expect_ALU_Control) && (ALUSrc == expect_ALUSrc) && (ImmSrc == expect_ImmSrc) && (ResultSrc == expect_ResultSrc) && 
		    (PCSrc == expect_PCSrc) && (JALR_Src == expect_JALR_Src) && (AUIPC_Src == expect_AUIPC_Src) && (Ext_Data_Val == expect_Ext_Data_Val) &&
		    (Ext_Data_Src == expect_Ext_Data_Src) && (Ext_rs2_Src == expect_Ext_rs2_Src) && (MemWrite == expect_MemWrite) &&
		    (RegWrite == expect_RegWrite)) begin
		    	$display("---------- PASS ----------");
		end else begin
			$display("-------------------------------------- FAIL --------------------------------------");
			$display("Op: %b | funct3: %b | funct7_5: %b | GES: %b", in_temp[33:27], in_temp[26:24], in_temp[23], in_temp[22:20]);
			$display("ALU_Control: %b | expected: %b", ALU_Control, expect_ALU_Control);
			$display("ALUSrc: %b | expected: %b", ALUSrc, expect_ALUSrc);
			$display("ImmSrc: %b | expected: %b", ImmSrc, expect_ImmSrc);
			$display("ResultSrc: %b | expected: %b", ResultSrc, expect_ResultSrc);
			$display("PCSrc: %b | expected: %b", PCSrc, expect_PCSrc);
			$display("JALR_Src: %b | expected: %b", JALR_Src, expect_JALR_Src);
			$display("AUIPC_Src: %b | expected: %b", AUIPC_Src, expect_AUIPC_Src);
			$display("Ext_Data_Val: %b | expected: %b", Ext_Data_Val, expect_Ext_Data_Val);
			$display("Ext_Data_Src: %b | expected: %b", Ext_Data_Src, expect_Ext_Data_Src);
			$display("Ext_rs2_Src: %b | expected: %b", Ext_rs2_Src, expect_Ext_rs2_Src);
			$display("MemWrite (WE): %b | expected: %b", MemWrite, expect_MemWrite);
			$display("RegWrite (WE3): %b | expected: %b", RegWrite, expect_RegWrite);
			$display("----------------------------------------------------------------------------------");
		end

	end
endtask

				


endmodule


