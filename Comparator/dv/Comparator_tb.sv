`timescale 1ns/1ps
module Comparator_tb;

   logic [31:0] A, B;
   logic sign;
   logic [2:0] ges;

   // Instance Comparator DUT
   Comparator dut (
	   .A(A),
	   .B(B),
	   .sign(sign),
	   .GES(ges)
   );

   initial begin
	   $dumpfile("Comparator_wave.vcd");
	   $dumpvars(0, Comparator_tb);
   end

   initial begin
	   // Initial
	   A = 32'h0000_0000;
	   B = 32'h0000_0000;
	   sign = 1'b0;
   end

   initial begin
	   int i;
	   logic [31:0] valA;
	   logic [31:0] valB;
	   logic valsign;
	   // Loop for un-signed test
	   $display("***************************************************************************");
	   $display("******************** Test un-signed case with sign = 0 ********************");
	   $display("***************************************************************************");
	   valsign = 0;
	   for (i=0; i<1000000; i++) begin
		   valA = $urandom();
		   valB = $urandom();
		   test_compare (valA, valB, valsign);
	   end
	   
	   // Loop for signed test
	   $display("***************************************************************************");
	   $display("********************* Test signed case with sign = 1 **********************");
	   $display("***************************************************************************");
	   valsign = 1;
	   i = 0;
	   for (i=0; i<1000000; i++) begin
		   valA = $random();
		   valB = $random();
		   test_compare (valA, valB, valsign);
	   end


	   #20;
	   $finish;
   end


   task automatic test_compare (input logic [31:0] inA, input logic [31:0] inB, input logic in_sign);
	logic [2:0] expected_ges;
	logic signed [31:0] sA, sB;
	logic [31:0] uA, uB;

	begin
		A = inA;
		B = inB;
		sign = in_sign;
		#10;

		if (sign == 1'b0) begin
			uA = A;
			uB = B;
			if (uA > uB)
				expected_ges = 3'b100;
			else if (uA == uB)
				expected_ges = 3'b010;
			else
				expected_ges = 3'b001;
		end else begin
			sA = $signed(A);
			sB = $signed(B);
			if (sA > sB)
				expected_ges = 3'b100;
			else if (sA == sB)
				expected_ges = 3'b010;
			else
				expected_ges = 3'b001;
		end

		if (ges != expected_ges) begin
			$display("FAIL: A = %b B = %b sign = %b | ges = %b @time %0t", inA, inB, in_sign, ges, $time);
			$display("-----------------------------------------------------------------------------------");
			$finish;
		end else begin
			$display("PASS: A = %b B = %b sign = %b | ges = %b @time %0t", inA, inB, in_sign, ges, $time);
			$display("-----------------------------------------------------------------------------------");
		end
	end
	endtask
	endmodule	
