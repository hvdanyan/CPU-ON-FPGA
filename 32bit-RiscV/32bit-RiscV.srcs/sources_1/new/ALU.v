module ALU(
    input clock,
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALU_op,
    output [31:0] result,
    output zero,
    output less
);
    wire [31:0] result_temp;
    wire zero_temp;
    wire less_temp;
    wire [3:0] ALU_op_part;  // 中间信号
    
    assign ALU_op_part = ALU_op[3:0];  // 将部分信号赋值给中间信号
    
    always @(posedge) begin
        if (ALU_op[2:0] == 3'b000)
            ALU_Adder ALU_Adder_inst(A, B, ALU_op_part, result_temp, zero_temp, less_temp);
        if ((ALU_op[2:0] == 3'b001) || (ALU_op[2:0] == 3'b101))
            ALU_Shifter ALU_Shifter_inst(A, B, ALU_op_part, result_temp, zero_temp, less_temp);
        if ((ALU_op[2:0] == 3'b100) || (ALU_op[2:0] == 3'b110) || (ALU_op[2:0] == 3'b111))
            ALU_Logic ALU_Logic_inst(A, B, ALU_op_part, result_temp, zero_temp, less_temp);
        if (ALU_op[2:0] == 3'b010)
            ALU_Sub ALU_Sub_inst(A, B, ALU_op_part, result_temp, zero_temp, less_temp);
        if (ALU_op[2:0] == 3'b011)
            result_temp = B[31:0];
    end
    
    assign result = result_temp;
    assign zero = zero_temp;
    assign less = less_temp;
    
endmodule