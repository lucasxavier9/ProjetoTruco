module bin2BCD(
    input logic [7:0] bin,
    output logic [3:0] dez,
    output logic [3:0] und
    );

	integer i;
	
	always_comb begin
		dez = 4'b0000;
		und = 4'b0000;
		
		for (i=7; i>=0; i=i-1) begin
			if (dez >= 4'd5) dez = dez + 4'd3;
			if (und >= 4'd5) und = und + 4'd3;
			
			dez = dez << 1;
			dez[0] = und[3];
			
			und = und << 1;
			und[0] = bin[i];
		end
	end

endmodule
