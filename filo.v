module filo (clk, data_in, reset, read_write, data_out, empty, full, last);

	input[31:0] data_in;
	input clk, reset, read_write;
	
	reg[5:0] this_last;
	reg[31:0] r1, r2 , r3, r4, r5, r6, r7, r8, r9, r10;
	reg[31:0] r11, r12 , r13, r14, r15, r16;
	
	output reg[31:0] data_out;
	output reg[5:0] last;
	output reg empty, full;
	
	/* on clock click */
	always @(data_in or reset)
	begin

		if (reset == 1'b1)
		begin
			empty = 1;
			full = 0;			
			this_last = 0;
			last = this_last;
			$write("\n***Module filo reset: on. ");
			$write("Empty: %b Full: %b Last: %d \n\n", empty, full, this_last);
		end
		else if (reset == 1'b0)
		begin

			if (read_write == 1'b0) // if push mode and data_in initialized
			begin
					case(this_last) // find stack height and write input to the next stack reg
						0 : r1 = data_in;
						1 : r2 = data_in;
						2 : r3 = data_in;
						3 : r4 = data_in;
						4 : r5 = data_in;
						5 : r6 = data_in;
						6 : r7 = data_in;
						7 : r8 = data_in;
						8 : r9 = data_in;
						9 : r10 = data_in;
						10: r11 = data_in;
						11: r12 = data_in;
						12: r13 = data_in;
						13: r14 = data_in;
						14: r15 = data_in;
						15:
							begin
								r16 = data_in; // r16 filled
								full = 1;	// now stack is full
							end
						default :
							begin
								data_out = 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
								$write("\n***\nStack is full, data_in didn't stored.\n***\n");
							end
					endcase

					if (this_last < 16)
					begin
						data_out = data_in; // if value registered correctly, show it at output
						this_last = this_last + 1;
						last = this_last;
					end
					
					if (this_last > 0) empty = 0;

			end // if write mode
			else if (read_write == 1'b1)// if read mode
			begin
			
					case(this_last) // find stack height and write input to the next stack reg
						16 : data_out = r16;
						15 : data_out = r15;
						14 : data_out = r14;
						13 : data_out = r13;
						12 : data_out = r12;
						11 : data_out = r11;
						10: data_out = r10;
						9 : data_out = r9;
						8 : data_out = r8;
						7 : data_out = r7;
						6 : data_out = r6;
						5 : data_out = r5;
						4 : data_out = r4;
						3 : data_out = r3;
						2 : data_out = r2;
						1 : data_out = r1;
						default :
							begin
								empty = 1;
								data_out = 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
								$write("\n***\nStack is empty!!!\n***\n");
							end
					endcase
					
					if (this_last > 0)
					begin
						this_last = this_last - 1;
						last = this_last;
					end
					
					if (this_last < 1) empty = 1;
					if (this_last < 16) full = 0;
					
			end
		end // if reset off
	end // always clock
	
endmodule // filo

module top();

	/* reg for inputs and regs */
	reg[31:0] data_in;
	integer clk = 0;
	reg reset = 1'b0;
	reg read_write;

	/* wire for output */
	wire[31:0] data_out;
	wire[5:0] last; // integer 0-16
	wire empty, full;

	filo myFilo(clock, data_in, reset, read_write, data_out, empty, full, last);
	
	initial begin
		$dumpfile("filo.vcd");
		$dumpvars(0);

		/* Initialize module - Reset */
		reset = 1'b1;

		#10
		reset = 1'b0;
		
		#10
		read_write = 1'b0; // set module to push mode

		repeat(17)
		begin
			#10
				data_in = $time;
				
			#100
				/* print results */
				$write("Time: ", $time, "\n"); 
				$write("Data_in: \t%d \n", data_in);
				$write("Data_out:\t%d \tEmpty: %d Full: %d Last: %d \n", data_out, empty, full, last);
				$write("\n");
		end

		$write("\n\n*** popping *** \n\n");

		/* Empty stack - Pop*/
		#10
		read_write = 1'b1; // set module to pop mode
		
		repeat(17)
		begin
			data_in = data_in + 1; // random input to instead of clock
			#100
				
				/* print results */
				$write("Time: ", $time, "\n"); 
				$write("Data_out:\t%d \tEmpty: %d Full: %d Last: %d \n", data_out, empty, full, last);
				$write("\n");
		end

		/* Finish top */
		#10 $finish;
		
	end // initial begin
endmodule // top
