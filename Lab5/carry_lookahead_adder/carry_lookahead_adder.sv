//`include "fulladder.sv"
module carry_lookahead_adder#(parameter N=4)(
  input logic[N-1:0] A, B,
  input logic CIN,
  output logic[N:0] result
);

logic [N-1:0] C, G, P;
 // Add code for carry lookahead adder 
task calculate_carry(input logic A, B, CIN, output logic G, P, COUT);
  G = A & B;
  P = A | B;
  COUT = G | (P & CIN);
endtask
always_comb begin
calculate_carry(A[0], B[0], CIN, G[0], P[0], C[0]);
for (int i=1; i<N; i++) begin
  calculate_carry(A[i], B[i], C[i - 1], G[i], P[i], C[i]);
end
end

fulladder fulladder_inst(
  .a(A[0]),
  .b(B[0]),
  .cin(CIN),
  .sum(result[0]),
);

genvar i;
generate
  for (i = 1; i<N; i++) begin : gen_block
    fulladder adder(
      .a(A[i]),
      .b(B[i]),
      .cin(C[i - 1]),
      .sum(result[i]),
    );
  end
endgenerate
  
endmodule: carry_lookahead_adder
