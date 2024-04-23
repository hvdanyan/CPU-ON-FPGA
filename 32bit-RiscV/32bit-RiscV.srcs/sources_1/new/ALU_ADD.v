module ALU_Adder(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALU_op,    // �� ALU_op ����Ϊ����
    output reg [31:0] result,
    output zero,
    output less
);


    always@(*)
    begin
        if(ALU_op[3]==0) result = A+B;
        if(ALU_op[3]==1) result = A-B;
    end

    assign zero = (result == 0);
    
endmodule