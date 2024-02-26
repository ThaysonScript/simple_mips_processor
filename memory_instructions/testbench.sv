module memoria_instrucoes_tb;
  reg [31:0] counter_tb;
  reg clock_tb;
  wire [31:0] instrucao_saida_tb;
  
  // instantiate the memory:
  memoria_instrucoes dut(
    .counter(counter_tb),
    .clock(clock_tb),
    .instrucao_saida(instrucao_saida_tb)
  );
  
  initial begin
      // specify test points to be captured
    $dumpfile("latch.vcd");
    $dumpvars(1);
    $display("       |-- counter --|\t\t\t       |-- clock --|\t         |--  endereco  --|");
    $monitor("\t%d --|\t\t\t       |--   %d   --|\t         |-- %d --|", counter_tb, clock_tb, instrucao_saida_tb);
      
      // excercise the lines to test:

    	clock_tb=0;
     #5 clock_tb=1;
    
     #5	clock_tb=0;
     #5 clock_tb=1;
    
     #5 clock_tb=0;
     #5 clock_tb=1;
     #5 clock_tb=0;

    $finish;
  end
    
endmodule
