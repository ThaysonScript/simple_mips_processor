// -------------------------------------------------------------- START PC_COUNTER
module pc_counter(clock, endereco);
  	input clock;
  	reg [31:0] counter;
  	output reg [31:0] endereco;

  	initial begin
    	counter = 32'b00000000000000000000000000000000;
  	end

  	always @(negedge clock) begin
   		counter = counter + 32'b00000000000000000000000000000001;
  	end

  	assign endereco = counter;

endmodule
// -------------------------------------------------------------- END PC_COUNTER


// --------------------------------------------------------- START INSTRUCAO_MEMORIA
module memoria_instrucoes(counter, clock, instrucao_saida);
    input [31:0] counter;
	input clock;
  	output reg [31:0] instrucao_saida;
  
  	reg [31:0] memoria_instrucoes [99:0];  
    reg [31:0] counter_reg;

    always @(posedge clock) begin
      memoria_instrucoes[counter] <= 32'b00001000100000000001000000000000;

      counter_reg <= counter;
    end

    assign instrucao_saida = memoria_instrucoes[counter_reg];
      
endmodule
// --------------------------------------------------------- END INSTRUCAO_MEMORIA

// --------------------------------------------------- START BANCO_REGISTRADORES
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
// --------------------------------------------------- END BANCO_REGISTRADORES

// ------------------------------------------------- START ULA
// operacoes aritmeticas
// somente de adicao
module ula(opcode, data1_in, data2_in, data_out);
	input [4:0] opcode;
	input [31:0] data1_in;   
	input [31:0] data2_in;
  
  	output [31:0] data_out;
  
  	reg [31:0] result;
  
  	always @(data1_in or data2_in or opcode) begin
      	case(opcode) 5'b00001:
     		result = data1_in + data2_in;
   		
        default:
     		result = 32'b00000000000000000000000000000000;
  		
        endcase
	end
  
  assign data_out = result;
  
endmodule
// ------------------------------------------------- END ULA

// ------------------------------------------------------------ START CPU
module cpu(clock, valor_saida);
	input clock;					// entrada
  	output reg [31:0] valor_saida;		// saida
  
  	wire [31:0] counter;
    wire [31:0] instrucao;
    wire [31:0] data_ula;
  
    wire [31:0] valor_regd;
    wire [31:0] valor_reg1;
    wire [31:0] valor_reg2;

  	// clock = entrada
  	// counter = saida
  	pc_counter pc_counter_inst(clock, counter);
  
  	// counter = entrada
  	// clock = entrada
  	// instrucao = saida
  	memoria_instrucoes memoria_instrucoes_inst(counter, clock, instrucao);
  
  	/*
    
    	clock = entrada
        instrucao[26:22], instrucao[21:17], instrucao[16:12] = entrada
        data_ula = entrada
        valor_regd, valor_reg1, valor_reg2 = saida
    
    */
  	banco_registradores banco_registradores_inst(
      clock, instrucao[26:22], instrucao[21:17], instrucao[16:12],
      data_ula, valor_regd, valor_reg1, valor_reg2
  	);
  
  	// instrucao[31:27] = entrada
  	// valor_reg1, valor_reg2 = entrada
  	// data_ula = saida
  	ula ula_inst(
      instrucao[31:27],
      valor_reg1, valor_reg2, data_ula
    );
  
	assign valor_saida = valor_regd;	// resultado
  
endmodule
// ------------------------------------------------------------ END CPU
