module top (
	input logic clk, rst_n,
	output logic [31:0] RD1_temp, RD2_temp,
	output logic [31:0] PC_temp,
	output logic [6:0] op,
	output logic [2:0] funct3,
	output logic funct7_5,
	output logic [2:0] GES,
	output logic WE, WE3,
	

	// Check
	output logic [31:0] srcA, srcB,
	output logic [31:0] Result_data,
	output logic [1:0] result_src,
	output logic [31:0] Immdata,
	output logic [31:0] Instruction,
	output logic [31:0] Mem_Result,
	output logic [31:0] WD_temp,
	output logic [31:0] WD3_temp,
	output logic [31:0] ALU_result,
	output logic [31:0] io_val_ff,
	
	//
	output logic [31:0] Final_Addr_DataMem,
	input logic [1:0] SW_Src,
	input logic [7:0] io_val,
	input logic in_en, // in_en = WE_IO
	output logic WE_final,
	output logic [31:0] out_read
	);

// Signals of Control_unit
// Inputs
/*
logic [6:0] op;
logic [2:0] funct3;
logic funct7_5;
logic [2:0] GES;
*/
// Outputs 
logic [1:0] Ext_rs2_Src;
logic [31:0] Ext_rs2_Data;
logic PCSrc;
logic [1:0] ResultSrc;
logic [1:0] Ext_Data_Val;
logic Ext_Data_Src;
logic [3:0] ALU_Control;
logic ALUSrc;
logic [2:0] ImmSrc;
logic MemWrite; // WE
logic RegWrite; // WE3
logic AUIPC_Src, JALR_Src;

// Signals of Datapath
logic [31:0] PCNext, PC_JALR, PC, PC_plus4, PC_Target;
logic [31:0] Instr, WD3, RD1, RD2;
logic [31:0] Src1, Src2;
logic [31:0] Extended_Imm;
logic [31:0] WD, ALUResult;
//logic [31:0] Mem_Result;
logic [31:0] Result_Data, Extended_Data, Final_Data;

// Signals for add_io
logic [31:0] final_addr_datamem;
logic [31:0] final_wd_datamem;
logic sw_src;
//logic WE_final;
logic [31:0] addr_temp;
logic [31:0] io_val_temp;
logic [31:0] wd_temp;

// Instance moduel Control Unit
Control_unit	CU 			(.op(Instr[6:0]), .funct3(Instr[14:12]), .funct7_5(Instr[30]), .GES(GES),
									 .PCSrc(PCSrc), .Ext_rs2_Src(Ext_rs2_Src), .ResultSrc(ResultSrc), .Ext_Data_Val(Ext_Data_Val),
									 .Ext_Data_Src(Ext_Data_Src), .ALU_Control(ALU_Control), .ALUSrc(ALUSrc), .ImmSrc(ImmSrc),
									 .JALR_Src(JALR_Src), .AUIPC_Src(AUIPC_Src), .MemWrite(MemWrite), .RegWrite(RegWrite));


// Instances module relate to PC
mux2_1	PCNext_mux			(.in0(PC_plus4), .in1(PC_Target), .sel(PCSrc), .out(PCNext));
mux2_1	PC_JALR_mux			(.in0(PCNext), .in1(ALUResult), .sel(JALR_Src), .out(PC_JALR));
PC_ff		Program_Counter	(.clk(clk), .rst_n(rst_n), .d(PC_JALR), .q(PC));
FA32		PC_plus4_fa			(.a(PC), .b(32'h0000_0004), .cin(1'b0), .s(PC_plus4));
FA32		PC_target_fa		(.a(Extended_Imm), .b(PC), .cin(1'b0), .s(PC_Target));

// Instance module Instruction Memory
InstructionMem	InstrMem		(.A(PC), .RD(Instr));

// Instances module relate to Register File
Reg_file	reg_file				(.clk(clk), .rst_n(rst_n), .WE3(RegWrite), .A1(Instr[19:15]),
									 .A2(Instr[24:20]), .A3(Instr[11:7]), .WD3(WD3), .RD1(RD1), .RD2(RD2));
assign Src1 = RD1;
extend_unit	ExtendUnit		(.in(Instr[31:7]), .ImmSrc(ImmSrc), .out(Extended_Imm));
mux2_1	rd2_mux				(.in0(RD2), .in1(Extended_Imm), .sel(ALUSrc), .out(Src2));
extend_rs2	ExtendRS2		(.rd2(RD2), .Ext_rs2_Src(Ext_rs2_Src), .out(Ext_rs2_Data));

// Insatances module relate to Data Memory
assign WE_final = MemWrite ^ in_en;
DataMem	DataMemory			(.clk(clk), .WE(WE_final), .A(final_addr_datamem), .WD(final_wd_datamem), .RD(Mem_Result));

// Instance module ALU
ALU	ALU_Unit					(.Arg1(Src1), .Arg2(Src2), .ALU_Control(ALU_Control), .GES(GES), .ALUResult(ALUResult));

// Instances module relate to Mux of Result_data
mux4_1	Result_data_mux	(.in0(ALUResult), .in1(Mem_Result), .in2(PC_plus4), .in3(Extended_Imm), .sel(ResultSrc), .out(Result_Data));
extend_data	ExtendDat		(.init_data(Result_Data[15:0]), .ext_data_val(Ext_Data_Val), .extended_data(Extended_Data));
mux2_1	final_data_mux		(.in0(Result_Data), .in1(Extended_Data), .sel(Ext_Data_Src), .out(Final_Data));
mux2_1	wd3_mux				(.in0(Final_Data), .in1(PC_Target), .sel(AUIPC_Src), .out(WD3));


// Instance mux2_1 for selecting ADDRESS of Data Memory
mux4_1	addr_mux				(.in0(ALUResult), .in1(32'h0000_0030), .in2(32'h0000_0040), .in3(32'h0), .sel(SW_Src), .out(final_addr_datamem));
// Instance mux2-1 for selecting DATA from external or internal
mux2_1	in_val_mux			(.in0(Ext_rs2_Data), .in1(io_val_temp), .sel(in_en), .out(final_wd_datamem));
dff_32	wd_ff					(.clk(clk), .rst_n(1'b1), .en(in_en), .d(final_wd_datamem), .q(WD_temp[31:0]));
// D Flip FLop for input and output
dff_32	in_val				(.clk(clk), .rst_n(1'b1), .en(in_en), .d({24'h0, io_val[7:0]}), .q(io_val_temp));
dff_32	read_mem				(.clk(clk), .rst_n(rst_n), .en(SW_Src[1] & (~SW_Src[0])), .d(Mem_Result), .q(out_read));

// Assignment outputs
//assign RD = Mem_Result;
assign PC_temp = PC;
assign RD1_temp = RD1;
assign RD2_temp = RD2;
assign op = Instr[6:0];
assign funct3 = Instr[14:12];
assign funct7_5 = Instr[30];
assign srcA = Src1;
assign srcB = Src2;
assign Result_data = Result_Data;
assign result_src = ResultSrc;
assign Immdata = Extended_Imm;
assign Instruction = Instr;
assign WE = MemWrite;
assign WE3 = RegWrite;
//assign WD_temp = final_wd_datamem;
assign WD3_temp = WD3;
assign ALU_result = ALUResult;

assign Final_Addr_DataMem = final_addr_datamem;
assign io_val_ff = io_val_temp;
//assign addr_temp = {24'h00_0000, 8'h40};

endmodule : top

module dff_32
(
	input logic clk, rst_n, en,
	input logic [31:0] d,
	output logic [31:0] q
);

always_ff @(posedge clk or negedge rst_n) begin
	if (~rst_n)
		q <= 32'h0;
	else if (en)
		q <= d;
	else
		q <= q;
end

endmodule : dff_32