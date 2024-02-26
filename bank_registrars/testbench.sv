module banco_registradores_tb;
  reg clock_tb;
  reg [4:0] endereco_regd_tb;
  reg [4:0] endereco_reg1_tb;
  reg [4:0] endereco_reg2_tb;
  reg [31:0] data_in_tb;

  wire [31:0] valor_regd_tb;
  wire [31:0] valor_reg1_tb;
  wire [31:0] valor_reg2_tb;
  
  // instantiate the memory:
  banco_registradores dut(
    .clock(clock_tb), 
    .endereco_regd(endereco_regd_tb), 
    .endereco_reg1(endereco_reg1_tb),
    .endereco_reg2(endereco_reg2_tb), 
    .data_in(data_in_tb), 
    .valor_regd(valor_regd_tb), 
    .valor_reg1(valor_reg1_tb), 
    .valor_reg2(valor_reg2_tb)
  );
  
  initial begin
      // specify test points to be captured
    $dumpfile("latch.vcd");
    $dumpvars(1);
    $display("clock_tb, endereco_regd_tb, endereco_reg1_tb, endereco_reg2_tb, data_in_tb, valor_regd_tb, valor_reg1_tb, valor_reg2_tb");
    $monitor("%d\t\t     %d\t\t\t       %d\t\t\t    %d\t\t   %d\t   %d\t %d\t  %d", clock_tb, endereco_regd_tb, endereco_reg1_tb, endereco_reg2_tb, data_in_tb, valor_regd_tb, valor_reg1_tb, valor_reg2_tb
     );
      
    // excercise the lines to test:
    clock_tb = 0;
    endereco_regd_tb = 5'b00000;
    endereco_reg1_tb = 5'b00000;
    data_in_tb = 32'b00000000000000000000000000000011;
    #5 clock_tb = 1;

    #5 clock_tb = 0;
    endereco_regd_tb = 5'b00001;
    endereco_reg2_tb = 5'b00001;
    data_in_tb = 32'b00000000000000000000000000000101;
    #5 clock_tb = 1;
    #5 clock_tb = 0;

    $finish;
  end
    
endmodule
