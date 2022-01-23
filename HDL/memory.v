module data_memory(a, we, clk, wd, rd);
  input we, clk;
  input [31:0] a;
  input [31:0] wd;
  output reg [31:0] rd;
 
  parameter WORDS = (2**10)-1;

  reg [31:0] mem_data[0:WORDS];

  initial
    begin
      $readmemb("initzero.txt", mem_data);
    end

  always @ (posedge clk)
    begin 
      if (we) begin
        mem_data[a] = wd; 
      end
      else begin
        rd = mem_data[a]; 
      end 
    end
endmodule

module instruction_memory(a, rd);
  input [31:0] a;
  output reg [31:0] rd;

  // Note that at this point our programs cannot be larger then 64 subsequent commands.
  // Increase constant below if larger programs are going to be executed.
  reg [31:0] ram[0:63];

  initial
    begin
      $readmemb("memory.txt", ram);
    end

  always @ (*)
    begin 
        rd = ram[a]; 
      end 
endmodule

