// 4-bit ALU behavioral code
module alu #(
  parameter N = 4
) (
  input logic [N-1:0] operand1, operand2,
  input logic [N-1:0] operation,
  output logic [(2*N)-1:0] alu_out
);

  // always procedural block describing alu operations
  always @(operand1 or operand2 or operation) begin
    case (operation)
      4'b0000: alu_out = operand1 + operand2;         // Addition
      4'b0001: alu_out = operand1 - operand2;         // Subtraction
      4'b0010: alu_out = operand1 * operand2;         // Multiplication
      4'b0011: alu_out = operand1 / operand2;         // Division
      4'b0100: alu_out = operand1 & operand2;         // Bitwise AND
      4'b0101: alu_out = operand1 | operand2;         // Bitwise OR
      4'b0110: alu_out = operand1 ^ operand2;         // Bitwise XOR
      4'b0111: alu_out = ~(operand1 & operand2);      // Bitwise NAND
      4'b1000: alu_out = ~(operand1 | operand2);      // Bitwise NOR
      4'b1001: alu_out = ~(operand1 ^ operand2);      // Bitwise XNOR
      4'b1010: alu_out = operand1 << 1;               // Logical shift left
      4'b1011: alu_out = operand1 >> 1;               // Logical shift right
      4'b1100: alu_out = operand1 <<< 1;              // Arithmetic shift left
      4'b1101: alu_out = operand1 >>> 1;              // Arithmetic shift right
      4'b1110: alu_out = {{N{1'b0}}, operand1 && operand2}; // Logical AND
      4'b1111: alu_out = {{N{1'b0}}, operand1 || operand2}; // Logical OR
      default: alu_out = operand1 + operand2;         // Default: Addition
    endcase
  end

endmodule: alu