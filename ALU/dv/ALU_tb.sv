module ALU_tb;
   logic [31:0] Arg1, Arg2;
   logic [3:0]	ALU_Control;
   logic [2:0]	GES;
   logic [31:0] ALUResult;

	// Instance ALU DUT
	ALU dut (.*);

	initial begin
		$dumpfile("ALU_wave.vcd");
		$dumpvars(0, ALU_tb);
	end

	initial begin
		// Initialize
		Arg1		= 32'h0000_0000;
		Arg2		= 32'h0000_0000;
		ALU_Control	= 4'b0000;
		#10;
	end

	initial begin
		logic [31:0] test_in1, test_in2;
		logic [3:0] test_ALU_Control;
		int i;

		// Check ALU
		$display("************** Check Add ALU_Control = 0000 ***************");
		test_ALU_Control = 4'b0000;
		for (i=0; i<10000; i++) begin
			test_in1 = $random();
			test_in2 = $random();
			chk_ALU (test_in1, test_in2, test_ALU_Control);
		end

		$display("************** Check Sub ALU_Control = 0001 ***************");
		test_ALU_Control = 4'b0001;
		for (i=0; i<10000; i++) begin
			test_in1 = $random();
			test_in2 = $random();
			chk_ALU (test_in1, test_in2, test_ALU_Control);
		end

		$display("************** Check Shift Right Logical  ALU_Control = 0010 ***************");
		test_ALU_Control = 4'b0010;
		for (i=0; i<10000; i++) begin
			test_in1 = $random();
			test_in2 = $random();
			chk_ALU (test_in1, test_in2, test_ALU_Control);
		end

		$display("************** Check Shift Right Arithmetic ALU_Control = 0011 ***************");
		test_ALU_Control = 4'b0011;
		for (i=0; i<10000; i++) begin
			test_in1 = $random();
			test_in2 = $random();
			chk_ALU (test_in1, test_in2, test_ALU_Control);
		end

		$display("************** Check Shift Left Logical ALU_Control = 0100 ***************");
		test_ALU_Control = 4'b0100;
		for (i=0; i<10000; i++) begin
			test_in1 = $random();
			test_in2 = $random();
			chk_ALU (test_in1, test_in2, test_ALU_Control);
		end

		$display("************** Check XOR  ALU_Control = 0101 ***************");
		test_ALU_Control = 4'b0101;
		for (i=0; i<10000; i++) begin
			test_in1 = $random();
			test_in2 = $random();
			chk_ALU (test_in1, test_in2, test_ALU_Control);
		end

		$display("************** Check OR ALU_Control = 0110 ***************");
		test_ALU_Control = 4'b0110;
		for (i=0; i<10000; i++) begin
			test_in1 = $random();
			test_in2 = $random();
			chk_ALU (test_in1, test_in2, test_ALU_Control);
		end

		$display("************** Check AND ALU_Control = 0111 ***************");
		test_ALU_Control = 4'b0111;
		for (i=0; i<10000; i++) begin
			test_in1 = $random();
			test_in2 = $random();
			chk_ALU (test_in1, test_in2, test_ALU_Control);
		end

		$display("************** Check Un-signed Compare ALU_Control = 1000 ***************");
		test_ALU_Control = 4'b1000;
		for (i=0; i<10000; i++) begin
			test_in1 = $random();
			test_in2 = $random();
			chk_ALU (test_in1, test_in2, test_ALU_Control);
		end

		$display("************** Check Signed Compare ALU_Control = 1001 ***************");
		test_ALU_Control = 4'b1001;
		for (i=0; i<10000; i++) begin
			test_in1 = $random();
			test_in2 = $random();
			chk_ALU (test_in1, test_in2, test_ALU_Control);
		end
		
		$finish;
	end

	// Task check ALU
	task chk_ALU (input logic [31:0] in1, input logic [31:0] in2, input logic [3:0] in_ALU_Control);
		logic [31:0]	expected_ALUResult;
		logic [2:0] 	expected_GES;

		logic [31:0] u1, u2;
		logic signed [31:0] s1, s2;
		
		Arg1		= in1;
		Arg2		= in2;
		ALU_Control	= in_ALU_Control;
		#10;

		begin
			case (ALU_Control)
				4'b0000:	begin
							expected_ALUResult = in1 + in2;
						end

				4'b0001:	begin
							expected_ALUResult = in1 - in2;
						end

				4'b0010:	begin
							expected_ALUResult = in1 >> in2[4:0];
						end

				4'b0011:	begin
							expected_ALUResult = $signed(in1) >>> in2[4:0];
						end

				4'b0100:	begin
							expected_ALUResult = in1 << in2[4:0];
						end

				4'b0101:	begin
							expected_ALUResult = in1 ^ in2;
						end

				4'b0110:	begin
							expected_ALUResult = in1 | in2;
						end

				4'b0111:	begin
							expected_ALUResult = in1 & in2;
						end

				4'b1000:	begin
                        				u1 = in1;
                        				u2 = in2;
                        				if (u1 > u2)
                                				expected_GES = 3'b100;
                        				else if (u1 == u2)
                                				expected_GES = 3'b010;
                        				else
                                				expected_GES = 3'b001;
						end

				4'b1001:	begin
							s1 = $signed(in1);
                        				s2 = $signed(in2);
                        				if (s1 > s2)
                                				expected_GES = 3'b100;
                        				else if (s1 == s2)
                                				expected_GES = 3'b010;
                        				else
                                				expected_GES = 3'b001;
                				end

				default:	begin
							expected_ALUResult	= 32'h0000_0000;
							expected_GES		= 3'b000;
						end
			endcase
		#10;	
			if (ALUResult == expected_ALUResult && in_ALU_Control !== 4'b1000 && in_ALU_Control !== 4'b1001) begin
				$display("-------------------- PASS --------------------");
				$display("Actual value:");
				$display("ALUResult = 		%b", ALUResult);
				$display("Expected value:");
				$display("Expected_ALUResult = 	%b", expected_ALUResult);
				$display("----------------------------------------------");
			end else if ((GES == expected_GES) && (in_ALU_Control == 4'b1000 || in_ALU_Control == 4'b1001)) begin
				$display("-------------------- PASS --------------------");
				$display("Actual value:");
				$display("GES =		 %b", GES);
				$display("Expected value:");
				$display("Expected_GES = %b", expected_GES);
				$display("----------------------------------------------");
			end else begin
				$display("-------------------- FAIL --------------------");
				$display("Arg1 = %b", in1);
				$display("Arg2 = %b", in2);
				$display("Actual value:");
				$display("ALUResult = 		%b", ALUResult);
				$display("GES =		 %b", GES);
				$display("Expected value:");
				$display("Expected_ALUResult = 	%b", expected_ALUResult);
				$display("Expected_GES =   %b", expected_GES);
				$display("----------------------------------------------");
			end
		end
	endtask
endmodule			
