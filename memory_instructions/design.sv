// -------------------------------------------------------------- PC COUNTER
module pc_counter(clock, endereco);
  	input clock;
  	reg [31:0] counter;
  	output reg [31:0] endereco;

  	initial begin
    	counter = 32'b00000000000000000000000000000000;
  	end

  	always @(posedge clock) begin
   		counter = counter + 32'b00000000000000000000000000000001;
  	end

  	assign endereco = counter;

endmodule

// --------------------------------------------------------- MEMORIA INSTRUCAO
module memoria_instrucoes(counter, clock, instrucao_saida);
    input [31:0] counter;
	input clock;
  	output reg [31:0] instrucao_saida;
  
  	reg [31:0] memoria_instrucoes [99:0];  
  
  	pc_counter pc_counter_inst(clock, counter);

    initial begin
      memoria_instrucoes[0] <= 32'b00001000100000000001000000000000;
      memoria_instrucoes[1] <= 32'b00001000110000000001000000000000;
      memoria_instrucoes[2] <= 32'b00001001000000000001000000000000;
      memoria_instrucoes[3] <= 32'b00001001010000000001000000000000;
      
    end
  
  	assign instrucao_saida = memoria_instrucoes[counter];    
      
endmodule
