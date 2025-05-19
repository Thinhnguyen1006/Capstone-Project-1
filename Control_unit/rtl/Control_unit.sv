module Control_unit (
	input logic [6:0] op,
	input logic [2:0] funct3,
	input logic funct7_5,
	input logic [2:0] GES,
	output logic PCSrc,
	output logic [1:0] Ext_rs2_Src,
	output logic [1:0] ResultSrc,
	output logic [1:0] Ext_Data_Val,
	output logic Ext_Data_Src,
	output logic [3:0] ALU_Control,
	output logic ALUSrc,
	output logic [2:0] ImmSrc,
	output logic JALR_Src,
	output logic AUIPC_Src,
	output logic MemWrite,
	output logic RegWrite
);
// Concat op, funct3, funct7_5
logic [10:0] temp;
assign temp = {op[6:0], funct3[2:0], funct7_5};

// Generate ALU_Control[3:0] signal
assign ALU_Control[0] = ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & (~temp[1])) | 
								((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & (~temp[1])) |
								((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & temp[1] & temp[0]) |
								((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & temp[1]) |
								((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1]) & temp[0]) |
								((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & (~temp[1]) & (~temp[0])) |
								((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & (~temp[1]) & (~temp[0])) |
								((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & temp[1] & temp[0]) |
								((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & temp[1] & (~temp[0])) |
								(temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
								(temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1]) |
								(temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & (~temp[1])) |
								(temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & temp[1]);
								
assign ALU_Control[1] = ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & temp[1]) |
								((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & (~temp[1])) |
								((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & temp[1]) |
								((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & temp[1]) |
								((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & (~temp[1]) & (~temp[0])) |
								((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & temp[1] & (~temp[0]));
								
assign ALU_Control[2] = ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1] & (~temp[0])) |
								((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & (~temp[1])) |
								((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & (~temp[1])) |
								((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & temp[1]) |
								((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1] & (~temp[0])) |
								((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & (~temp[1]) & (~temp[0])) |
								((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & (~temp[1]) & (~temp[0])) |
								((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & temp[1] & (~temp[0]));
								
assign ALU_Control[3] = ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & (~temp[1])) |
								((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & temp[1]) |
								((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & (~temp[1]) & (~temp[0])) |
								((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & temp[1] & (~temp[0])) |
								(temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
								(temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1]) |
								(temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & (~temp[1])) |
								(temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & temp[1]) |
								(temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & (~temp[1])) |
								(temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & temp[1]);
								
								
// Generate PCSrc signal
logic beq_en, bne_en, blt_en, bge_en, bltu_en, bgeu_en;

assign beq_en = (temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4]) & ((~temp[3]) & (~temp[2]) & (~temp[1]) & GES[1]);
assign bne_en = (temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4]) & ((~temp[3]) & (~temp[2]) & temp[1] & (~GES[1]));
assign blt_en = (temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4]) & (temp[3] & (~temp[2]) & (~temp[1]) & GES[0]);
assign bge_en = (temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4]) & (temp[3] & (~temp[2]) & temp[1] & GES[2]);
assign bltu_en = (temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4]) & (temp[3] & temp[2] & (~temp[1]) & GES[0]);
assign bgeu_en = (temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4]) & (temp[3] & temp[2] & temp[1] & GES[2]);

assign PCSrc = (temp[10] & temp[9] & (~temp[8]) & temp[7] & temp[6] & temp[5] & temp[4]) | beq_en | bne_en | blt_en | bge_en | bltu_en | bgeu_en;
					
					
// Generate Ext_rs2_Src[1:0] signal
assign Ext_rs2_Src[0] = ((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1]);
assign Ext_rs2_Src[1] =	((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1]));

// Generate ResultSrc[1:0] signal
assign ResultSrc[0] = ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
							 ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1]) |
							 ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & (~temp[1])) |
							 ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & (~temp[1])) |
							 ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & temp[1]) |
							 ((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
							 ((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1]) |
							 ((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & (~temp[1])) |
							 ((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & temp[6] & temp[5] & temp[4]);
							 
assign ResultSrc[1] = (temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & temp[6] & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
							 (temp[10] & temp[9] & (~temp[8]) & temp[7] & temp[6] & temp[5] & temp[4]) |
							 ((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
							 ((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1]) |
							 ((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & (~temp[1])) |
							 ((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & temp[6] & temp[5] & temp[4]);

// Gnerate Ext_Data_Val[1:0] signal
assign Ext_Data_Val[0] = ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
								 ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & (~temp[1]));

assign Ext_Data_Val[1] = ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
								 ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1]);
							 
// Generate Ext_Data_Src signal
assign Ext_Data_Src = ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2])) |
								 ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]));		 
						
// Generate ALUSrc signal
assign ALUSrc = ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
					 ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1]) |
					 ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & (~temp[1])) |
					 ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & (~temp[1])) |
					 ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & temp[1]) |
					 ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
					 ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1] & (~temp[0])) |
					 ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & (~temp[1])) |
					 ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & temp[1]) |
					 ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & (~temp[1])) |
					 ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & temp[1]) |
					 ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & (~temp[1])) |
					 ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & temp[1]) |
					 ((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
					 ((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1]) |
					 ((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & (~temp[1])) |
					 (temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & temp[6] & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1]));

// Generate ImmSrc[2:0] signal					 
assign ImmSrc[0] = ((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
						 ((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1]) |
						 ((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & (~temp[1])) |
						 (temp[10] & temp[9] & (~temp[8]) & temp[7] & temp[6] & temp[5] & temp[4]) |
						 ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1] & (~temp[0])) |
						 ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & temp[1]);
					 
assign ImmSrc[1] = ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2])) |
						 ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & (~temp[1])) |
						 ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2])) |
						 (temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2])) |
						 (temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2])) |
						 (temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2]) |
						 (temp[10] & temp[9] & (~temp[8]) & temp[7] & temp[6] & temp[5] & temp[4]);
						 
assign ImmSrc[2] = ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1] & (~temp[0])) |
						 ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & temp[1]) |
						 ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & temp[6] & temp[5] & temp[4]) |
						 ((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & temp[6] & temp[5] & temp[4]); 
						 
// Generate JALR_Src signal
assign JALR_Src = (temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & temp[6] & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1]));

// Generate AUIPC_Src signal
assign AUIPC_Src = ((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & temp[6] & temp[5] & temp[4]);

// Generate MemWrite signal (WE)
assign MemWrite = ((~temp[10]) & temp[9] & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4]);

// Generate RegWrite signal (WE3)
assign RegWrite = ((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2])) |
						((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & (~temp[1])) |
						((~temp[10]) & (~temp[9]) & (~temp[8]) & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2])) |
						((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
						((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1] & (~temp[0])) |
						((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2]) |
						((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2])) |
						((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2]) |
						((~temp[10]) & (~temp[9]) & temp[8] & (~temp[7]) & temp[6] & temp[5] & temp[4]) |
						((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
						((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & temp[1] & (~temp[0])) |
						((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & (~temp[3]) & temp[2] & (~temp[0])) |
						((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & (~temp[1]) & (~temp[0])) |
						((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & (~temp[2]) & temp[1]) |
						((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & (~temp[6]) & temp[5] & temp[4] & temp[3] & temp[2] & (~temp[0])) |
						((~temp[10]) & temp[9] & temp[8] & (~temp[7]) & temp[6] & temp[5] & temp[4]) |
						(temp[10] & temp[9] & (~temp[8]) & (~temp[7]) & temp[6] & temp[5] & temp[4] & (~temp[3]) & (~temp[2]) & (~temp[1])) |
						(temp[10] & temp[9] & (~temp[8]) & temp[7] & temp[6] & temp[5] & temp[4]);

		
endmodule : Control_unit
