module test(input clk);

	always @(clk) $write("Clock: %b\n", clk);
	
endmodule

module top();

	reg clk;
	
	test myTest(clk);
	
	initial #100 clk = 1'b0;
	
	always #100 clk = ~clk;
	

endmodule
