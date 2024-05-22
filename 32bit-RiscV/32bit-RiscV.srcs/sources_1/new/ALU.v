module ALU(
    input CLK,
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALU_op,
    output [31:0] result,
    output zero,
    output less
);

    reg [31:0] result_reg;
    reg zero_reg,less_reg;
    
    always @(*) begin
        case(ALU_op[2:0])
            3'b000: result_reg = ALU_op[3] ? A - B : A + B;
            3'b001: result_reg = A << B;
            3'b010: begin
                result_reg = ALU_op[3] ? (A < B ? 1'b1 : 1'b0) : ($signed(A) < $signed(B) ? 1'b1 : 1'b0);
                less_reg = result_reg;
                zero_reg = A == B ? 1'b1 : 1'b0;
            end
            3'b011: result_reg = B;
            3'b100: result_reg = A ^ B;
            3'b101: result_reg = ALU_op[3] ? A >>> B : A >> B;
            3'b110: result_reg = A | B;
            3'b111: result_reg = A & B;
            default: result_reg = 0;
        endcase
    end
    
    assign result = result_reg;
    assign zero = zero_reg;
    assign less = less_reg;
    
endmodule