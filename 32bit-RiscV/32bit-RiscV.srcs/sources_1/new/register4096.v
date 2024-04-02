`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/01 17:09:47
// Design Name: 
// Module Name: register4096
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register4096(
   input CLK,
   input [0:4095]write,
   input [7:0] Bytein,
   output [0:4095][7:0] Byteouts
    );
     genvar i;
       
       generate
       for(i=0;i<4095;i=i+1)
       begin
       register register_inst(CLK,write[i],Bytein,Byteouts[i]);
       end
       endgenerate
endmodule
