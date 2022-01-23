module register_file(clk, we3, a1, a2, a3, wd3, rd1, rd2);
  input clk, we3;
  input [4:0] a1, a2, a3;
  input [31:0] wd3;
  output reg [31:0] rd1, rd2;

  reg [31:0] registers [31:0];
 
  initial
    begin
      $readmemb("initzero.txt", registers);
    end

  always @(posedge clk)
    begin
      if (we3) begin
        registers[a3] = wd3; 
        //rd1 = registers[a1];
        //rd2 = registers[a2];
      end
      else begin
        registers[a3] = registers[a3]; 
       // rd1 = registers[a1];
        //rd2 = registers[a2];
      end
    end

  always @(*)
    begin
      rd1 = registers[a1];
      rd2 = registers[a2];
    end
endmodule
