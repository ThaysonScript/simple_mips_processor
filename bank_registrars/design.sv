// --------------------------------------------------- BANCO REGISTRADORES
module banco_registradores(clock, endereco_regd, endereco_reg1, endereco_reg2, data_in, valor_regd, valor_reg1, valor_reg2);
	input clock;
  	input [4:0] endereco_regd;
	input [4:0] endereco_reg1;
	input [4:0] endereco_reg2;
  	input [31:0] data_in;
  	
  	output reg [31:0] valor_regd;
	output reg [31:0] valor_reg1;
	output reg [31:0] valor_reg2;
  	
  	reg [31:0] registradores[31:0];
  	initial begin
      	registradores[5'b00000] = 32'b00000000000000000000000000000011;		// registrador0 = 3
        registradores[5'b00001] = 32'b00000000000000000000000000000101;		// registrador1 = 5
	end
  
  	always @(posedge clock) begin
 		registradores[endereco_regd] <= data_in; 
	end
  
  	assign valor_regd = registradores[endereco_regd];
	assign valor_reg1 = registradores[endereco_reg1];
	assign valor_reg2 = registradores[endereco_reg2];
  
endmodule
