module KSA_top_tb;
   logic [31:0] a;
   logic [31:0] b;
   logic cin;
   logic [31:0] sum;
   logic cout;

	// Instance KSA_top DUT
	KSA_top dut (.*);

	initial begin
		$dumpfile("KSA_top_wave.vcd");
		$dumpvars(0, KSA_top_tb);
	end

	initial begin
		// Initialize
		a = 32'h0000_0000;
		b = 32'h0000_0000;
		cin = 1'b0;
	end

	initial begin
		// Check KSA_top
		logic [31:0] val_a;
		logic [31:0] val_b;
		logic val_cin;
		int i;

		// Test Adder
		$display("-------------------- ADDER --------------------");
		val_cin = 1'b0;
		for (i=0; i<10000; i++) begin
			val_a = $random();
			val_b = $random();
			chk_add_sub(val_a, val_b, val_cin);
		end

		// test Subtraction
		$display("----------------- SUBTRACTION -----------------");
		val_cin = 1'b1;
		for (i=0; i<10000; i++) begin
			val_a = $random();
			val_b = $random();
			chk_add_sub(val_a, val_b, val_cin);
		end
		$finish;
	end

	// Task check Add-Sub
	task chk_add_sub (input logic [31:0] ina, input logic [31:0] inb, input logic in_cin);
		logic [31:0] expected_sum;
		logic expected_cout;
		
		begin
			a 	= ina;
			b 	= inb;
			cin 	= in_cin;
			#5;
			if (in_cin == 0) begin
				expected_sum = a + b;
			end else begin
				expected_sum = a - b;	
			end

			if (sum == expected_sum) begin
				$display("-------------------- PASS --------------------");
				$display("a = %b | b = %b | cin = %b", ina, inb, in_cin);
				$display("Actual value:   %b", sum);
				$display("Expected value: %b", expected_sum);

			end else begin
				$display("-------------------- FAIL --------------------");
				$display("a = %b | b = %b | cin = %b", ina, inb, in_cin);
				$display("Actual value:   %b", sum);
				$display("Expected value: %b", expected_sum);
				$finish;
			end
		end
	endtask

endmodule
