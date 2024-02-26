module cpu_tb;
  reg clock_tb;
  wire [31:0] valor_saida_tb;
  
  // instantiate the memory:
  cpu dut(
    .clock(clock_tb),
    .valor_saida(valor_saida_tb)
  );
  
  initial begin
      // specify test points to be captured
    $dumpfile("latch.vcd");
    $dumpvars(1);
    $display("clock\tvalor_saida");
    $monitor("%b\t%b", clock_tb, valor_saida_tb);
    
     	 clock_tb=0;
     #10 clock_tb=1;
     #10 clock_tb=0;
     #10 clock_tb=1;
     #10 clock_tb=0;
    
    $finish;
  end
  
endmodule
