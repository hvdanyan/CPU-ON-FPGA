module ALU(
    input [31:0] A,
    input [31:0] B,
    input [3:0] ALU_op,
    output [31:0] result,
    output zero,
    output less
);

    reg [31:0] result_temp;
    reg zero_temp,less_temp;
    
    always @(*) begin
        case(ALU_op[2:0])
            3'b000: result_temp = ALU_op[3] ? A - B : A + B;
            3'b001: result_temp = A << B;
            3'b010: begin
                result_temp = ALU_op[3] ? (A < B ? 1'b1 : 1'b0) : ($signed(A) < $signed(B) ? 1'b1 : 1'b0);
                less_temp = result_temp;
                zero_temp = A == B ? 1'b1 : 1'b0;
            end
            3'b011: result_temp = B;
            3'b100: result_temp = A ^ B;
            3'b101: result_temp = ALU_op[3] ? A >>> B : A >> B;
            3'b110: result_temp = A | B;
            3'b111: result_temp = A & B;
            default: result_temp = 0;
        endcase
    end
    
    assign result = result_temp;
    assign zero = zero_temp;
    assign less = less_temp;
    
endmodule