module decoder_3to8(out7, out6, out5, out4, out3, out2, out1, out0, 
										 in0, in1, in2, enable);

	output out7, out6, out5, out4, out3, out2, out1, out0;
	input in0, in1, in2, enable;
	reg out7, out6, out5, out4, out3, out2, out1, out0;
	
	always @(in0 or in1 or in2 or enable) begin
		
		if ( enable == 1'b1 )
			case ( {in0, in1, in2} )
				3'b000:
					{ out7, out6, out5, out4, out3, out2, out1, out0 }
					= 8'b00000001;
				3'b001:
					{ out7, out6, out5, out4, out3, out2, out1, out0 }
					= 8'b00000010;
				3'b010:
					{ out7, out6, out5, out4, out3, out2, out1, out0 }
					= 8'b00000100;
				3'b011:
					{ out7, out6, out5, out4, out3, out2, out1, out0 }
					= 8'b00001000;
				3'b100:
					{ out7, out6, out5, out4, out3, out2, out1, out0 }
					= 8'b00010000;
				3'b101:
					{ out7, out6, out5, out4, out3, out2, out1, out0 }
					= 8'b00100000;
				3'b110:
					{ out7, out6, out5, out4, out3, out2, out1, out0 }
					= 8'b01000000;
				3'b111:
					{ out7, out6, out5, out4, out3, out2, out1, out0 }
					= 8'b10000000;
				default:
					{ out7, out6, out5, out4, out3, out2, out1, out0 }
					= 8'bxxxxxxxx;
			endcase
		else if ( enable == 1'b0 )
			{ out7, out6, out5, out4, out3, out2, out1, out0 }
					= 8'b11111111;
		end // if enable
endmodule

module top();
	reg in0, in1, in2, enable;
	wire out7, out6, out5, out4, out3, out2, out1, out0;
	decoder_3to8 myDecoder(out7, out6, out5, out4, out3, out2, out1, out0, 
										 			in0, in1, in2, enable);

	initial
	begin
		$dumpfile("Decoder.vcd");
		$dumpvars(0);
	
		$display("\t\ttime out7 out6 out5 out4 out3 out2 out1 out0  in0 in1 in2 enable");
		$monitor($time ,"    %b    %b    %b    %b    %b    %b    %b    %b    %b   %b   %b      %b",
							out7, out6, out5, out4, out3, out2, out1, out0, in0, in1, in2, enable);
							
		// time = 0
		enable = 1'b1;
		{in0, in1, in2} = 3'b000;
	
		#10 // time += 10
		{in0, in1, in2} = 3'b001;
	
		#10 // time += 10
		{in0, in1, in2} = 3'b010;
		#10 // time += 10
		{in0, in1, in2} = 3'b011;
		#10 // time += 10
		{in0, in1, in2} = 3'b100;
		#10 // time += 10
		{in0, in1, in2} = 3'b101;
		#10 // time += 10
		{in0, in1, in2} = 3'b110;				
		#10 // time += 10
		{in0, in1, in2} = 3'b111;									
		#10 // time += 10
		enable = 1'b0;
		#10 // time += 10
		$finish;
						
	end
	
endmodule
