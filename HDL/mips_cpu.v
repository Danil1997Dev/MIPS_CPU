`include "alu.v"
`include "control_unit.v"
`include "util.v"

module mips_cpu(clk, instruction_memory_a, instruction_memory_rd, data_memory_a, data_memory_rd, data_memory_we, data_memory_wd,
                register_a1, register_a2, register_a3, register_we3, register_wd3, register_rd1, register_rd2);
  input clk;
  output data_memory_we;
  output [31:0] instruction_memory_a, data_memory_a, data_memory_wd;
  inout [31:0] instruction_memory_rd, data_memory_rd;
  output register_we3;
  output [4:0] register_a1, register_a2, register_a3;
  output [31:0] register_wd3;
  inout [31:0] register_rd1, register_rd2; 
  
  wire [31:0] reg_instruction_a;  
  wire [31:0] instruction_a;
  wire [31:0] instruction_a_1;
  wire [31:0] instruction_a_branch;
  wire [31:0] instruction_a_new;  

  wire [4:0] rt_rd; 

  wire [31:0] aluresult;
  wire [31:0] data;

  wire [31:0] srca;
  wire [31:0] srcb;

  wire memtoreg;
  wire memwrite;
  wire branch;
  wire alusrc;
  wire regdst;
  wire [2:0] alucontrol;

  wire zero; 

  wire [31:0] extend_const;
  wire [31:0] extend_const_shl;

  alu alu_inst(srca, 
	      srcb, 
	      alucontrol, 
	      aluresult, 
	      zero);

  control_unit control_unit_inst(instruction_memory_rd[31:26], 
			     instruction_memory_rd[5:0], 
			     memtoreg, 
			     memwrite, 
			     branch, 
			     alusrc, 
			     regdst, 
			     regwrite, 
			     alucontrol);

  shl_2 shl_2_inst(extend_const, extend_const_shl);
  sign_extend sign_extend_inst(instruction_memory_rd[15:0], extend_const); 

  d_flop d_flop_instr_adr_in_inst(instruction_a, clk, reg_instruction_a);  
  adder adder_cnt_inst(reg_instruction_a, 32'd4, instruction_a_1); 
  adder adder_branch_inst(instruction_a_1, extend_const_shl, instruction_a_branch);  
  mux2_32 mux2_32_intr_adr_inst(instruction_a_1, instruction_a_branch, branch_en, instruction_a_new);
  d_flop d_flop_instr_adr_out_inst(instruction_a_new, clk, instruction_a);
 
  mux2_32 mux2_32_srcb_inst(register_rd2, extend_const, alusrc, srcb);
  mux2_32 mux2_32_data_inst(aluresult, data_memory_rd, memtoreg, data);
  mux2_5 mux2_5_inst(instruction_memory_rd[20:16], instruction_memory_rd[15:11], regdst, rt_rd);
  assign branch_en = branch || zero;

  assign instruction_memory_a = reg_instruction_a;
  assign srca = register_rd1;
  assign data_memory_wd = register_rd2; 
  assign data_memory_a = aluresult;  
  assign data_memory_we = memwrite;  
  assign register_a1 = instruction_memory_rd[25:21];
  assign register_a2 = instruction_memory_rd[20:16];
  assign register_a3 = rt_rd;
  assign register_wd3 = data;  
  assign register_we3 = regwrite; 
 
endmodule
