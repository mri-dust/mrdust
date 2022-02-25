module edge_detector (
	input clk,
	input dataIn,
	input rst,
	output dataOut
);
	reg prev;

	always @(posedge clk) begin
		if (rst) prev <= 0;
		else prev <= dataIn;
	end

	assign dataOut = ~dataIn & prev;
endmodule
