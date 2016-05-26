module mux4_to_1 (i0,i1,i2,i3,s0,s1,out);

	input i0,i1,i2,i3,s0,s1;
	output out;
	/* wire can be ignored. everything that isn't wired compiler register them as wires */
	wire i0,i1,i2,i3,s0,s1,out;
	wire and0,and1,and2,and3,ns0,ns1;

	not(ns0,s0);
	not(ns1,s1);
	or(out,and0,and1,and2,and3);
	and(and0,i0,ns0,ns1);
	and(and1,i1,s0,ns1);
	and(and2,i2,ns0,s1);
	and(and3,i3,s0,s1);
	
endmodule // mux4_to_1

module top(); // module top is the module that can call our module
	reg i0,i1,i2,i3,s0,s1;
	wire out;
	mux4_to_1 my_mux(i0,i1,i2,i3,s0,s1,out); // my_mux is an instance of mux4_to_1

	initial 
	begin
		$dumpfile("Mux.vcd");
		$dumpvars(0); // give to dumpfile all variables
	
		$display("\t\ttime \ti0\ti1\ti2\ti3\ts0\ts1\tout"); // display doesn't monitor according time
		$monitor($time,"\t%b\t%b\t%b\t%b\t%b\t%b\t%b",i0,i1,i2,i3,s0,s1,out); // monitor displays according to time
	
		// time = 0
		{i3,i2,i1,i0} = 4'b0001; // i3=0 i2=0 i1=0 i0=1
		{s1,s0} = 2'b00;
	
		#10 // time += 10
		{i3,i2,i1,i0}=4'b0010;
		{s1,s0}=2'b01;
	
		#10 // time += 10
		{i3,i2,i1,i0}=4'b0100;
		{s1,s0}=2'b00;
	
		#10 // time += 10
		$finish;
	
	end // initial
endmodule // top

