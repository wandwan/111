// N-bit ALU TOP RTL code
module alu_top #(
  parameter N = 4
) (
  input logic clk, reset,
  input logic [N-1:0] operand1, operand2,
  input logic [N-1:0] select,
  output logic [(2*N)-1:0] result
);

  // Local net declaration
  logic [(2*N)-1:0] alu_out;

  // Instantiation of module alu
  alu #(
    .N(N)
  ) alu_inst (
    .operand1(operand1),
    .operand2(operand2),
    .operation(select),
    .alu_out(alu_out)
  );

  // Adding flipflop at the output of ALU
  always @(posedge clk or posedge reset) begin
    if (reset == 1) begin
      result <= 0;
    end
    else begin
      result <= alu_out;
    end
  end

endmodule: alu_top