
//discription:
//Reg_zero shows whether seg is zero.

module Zero_Flag(CLK,Reg_a,Reg_b,seg,Reg_zero);
input [7:0] Reg_a;
input [7:0] Reg_b;
input [7:0] seg;
input CLK;
output reg Reg_zero;
//reg [7:0] s;
always@(posedge CLK)
  if (seg==0)
  Reg_zero=1;
  else Reg_zero=0;
endmodule