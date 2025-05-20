module Barrel_shifter_tb;
   logic [31:0]	in;
   logic [1:0]	sel;
   logic [4:0]	B;
   logic [31:0]	out;

	// Instance Barrel_shifter DUT
	Barrel_shifter dut (.*);

	initial begin
		$dumpfile("Barrel_shifter_wave.vcd");
		$dumpvars(0, Barrel_shifter_tb);
	end

	initial begin
		// Initialize
		in	= 32'h0000_0000;
		sel	= 2'b00;
		B	= 5'b00000;
		#10;
	end

	initial begin
		// Check Barrel_shifter
		logic [31:0]	in_test;
		logic [1:0]	sel_test;
		logic [4:0]	B_test;

		int i;

		$display("-------------------- Right-Logical --------------------");
		for (i=0; i<10000; i++) begin
			sel_test	= 2'b00;
			in_test		= $random();
			B_test		= $random();
			chk_shifter (in_test, sel_test, B_test);
		end

		$display("------------------- Right-Arithmetic ------------------");
		for (i=0; i<10000; i++) begin
			sel_test	= 2'b01;
			in_test		= $random();
			B_test		= $random();
			chk_shifter (in_test, sel_test, B_test);
		end

		$display("-------------------- Left-Logical ---------------------");
		for (i=0; i<10000; i++) begin
			sel_test	= 2'b10;
			in_test		= $random();
			B_test		= $random();
			chk_shifter (in_test, sel_test, B_test);
		end

		$display("------------------- Left-Arithmetic -------------------");
		for (i=0; i<10000; i++) begin
			sel_test	= 2'b11;
			in_test		= $random();
			B_test		= $random();
			chk_shifter (in_test, sel_test, B_test);
		end
		#10;
		$finish;

	end

	// Task check shifter
	task chk_shifter (input logic [31:0] in_val, input logic [1:0] sel_val, input logic [4:0] B_val);
		logic [31:0] expected_out;

		begin
			in	= in_val;
			sel	= sel_val;
			B	= B_val;
			#10;

			if (sel_val == 2'b00) begin
				// Shift Right Logical
				expected_out = in_val >> B_val;
			end else if (sel_val == 2'b01) begin
				// Shift Right Arithmetic
				expected_out = $signed(in_val) >>> B_val;
			end else if (sel_val == 2'b10) begin
				// Shift Left Logical
				expected_out = in_val << B_val;
			end else begin
				// Shift Left Arithmetic = Shift Left Logical
				expected_out = in_val << B_val;
			end

			if (out == expected_out) begin
				$display("-------------------- PASS --------------------");
				$display("Input:	  %b", in_val);
				$display("B = %d", B_val);
				$display("Actual value:   %b", out);
				$display("Expected value: %b", expected_out);
				$display("----------------------------------------------");
			end else begin
				$display("--------------------FAIL --------------------");
				$display("Input:	  %b", in_val);
				$display("B = %d", B_val);
				$display("Actual value:   %b", out);
				$display("Expected value: %b", expected_out);
				$display("----------------------------------------------");
			end
		end
	endtask
	endmodule
