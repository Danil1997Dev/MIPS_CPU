module control_unit(opcode, funct, memtoreg, memwrite, branch, alusrc, regdst, regwrite, alucontrol);
  input [5:0] opcode, funct;
  output reg memtoreg, memwrite, branch, alusrc, regdst, regwrite;
  output reg [2:0] alucontrol;
 
  always @ (*) 
    begin 
	memtoreg = 0;
	memwrite = 0;
	branch = 0;
	alusrc = 0;
	regdst = 0;
	regwrite = 0; 

	alucontrol = 7;
      case(opcode)
        6'b100011://lw
          begin
	memtoreg = 1;
	memwrite = 0;
	branch = 0;
	alusrc = 1;
	regdst = 0;
	regwrite = 1; 

	alucontrol = 0;
           end
        6'b101011://sw
          begin
	memtoreg = 0;
	memwrite = 1;
	branch = 0;
	alusrc = 1;
	regdst = 0;
	regwrite = 0; 

	alucontrol = 0;
           end
        6'b000100://beq
          begin
	memtoreg = 0;
	memwrite = 0;
	branch = 1;
	alusrc = 0;
	regdst = 0;
	regwrite = 0; 

	alucontrol = 1;
           end

        6'b001000://addi
          begin
	memtoreg = 0;
	memwrite = 0;
	branch = 0;
	alusrc = 1;
	regdst = 0;
	regwrite = 1; 

	alucontrol = 0;
           end
        6'b000000://arithmetic
          begin
	memtoreg = 0;
	memwrite = 0;
	branch = 0;
	alusrc = 0;
	regdst = 1;
	regwrite = 1;

        case (funct)
        6'b100000://add
          begin
	alucontrol = 0;
           end
        6'b100010://sub
          begin
	alucontrol = 1;
           end
        6'b100100://and
          begin
	alucontrol = 2;
           end
        6'b100101://or
          begin
	alucontrol = 3;
           end
        6'b101010://slt
          begin
	alucontrol = 4;
           end  
        endcase
           end 
      endcase  
    end
 

endmodule