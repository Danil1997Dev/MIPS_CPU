module alu(srca, srcb, alucontrol, aluresult, zero);
  input [31:0] srca, srcb;
  input [2:0] alucontrol;
  output reg  [31:0] aluresult;
  output reg zero;

//arithmetic insruction

 reg signed [31:0] add_ina;
 reg signed [31:0] add_inb;
 wire signed [31:0] add_result;

 reg signed [31:0] sub_ina;
 reg signed [31:0] sub_inb;
 wire signed [31:0] sub_result;

 reg unsigned [31:0] and_ina;
 reg unsigned [31:0] and_inb;
 wire unsigned [31:0] and_result;

 reg unsigned [31:0] or_ina;
 reg unsigned [31:0] or_inb;
 wire unsigned [31:0] or_result;

 reg signed [31:0] slt_ina;
 reg signed [31:0] slt_inb;
 wire [31:0] slt_result;

  always @*
    begin 
      case(alucontrol)
        0:
          begin
	add_ina = srca;
	add_inb = srcb;
	aluresult = add_result; 
               zero = 0; 
               end
        1:
          begin
	sub_ina = srca;
	sub_inb = srcb;
	aluresult = sub_result;
               if (sub_result == 0)
                 zero = 1;
               else
                 zero = 0;
               end
        2:
          begin
	and_ina = srca;
	and_inb = srcb;
	aluresult = and_result;  
               zero = 0; 
               end
        3:
          begin
	or_ina = srca;
	or_inb = srcb;
	aluresult = or_result; 
               zero = 0;
               end
        4:
          begin
	slt_ina = srca;
	slt_inb = srcb;
	aluresult = slt_result; 
               zero = 0; 
           end 
        default:
          begin 
	aluresult = 0; 
               zero = 0; 
           end 
      endcase  
    end
 

  assign add_result = add_ina + add_inb;
  assign sub_result = sub_ina - sub_inb;
  assign and_result = and_ina && and_inb;
  assign or_result = or_ina || or_inb;
  assign slt_result = slt_ina < slt_inb;

//arithmetic insruction end
endmodule
