//`include "fulladder.sv"
module carry_lookahead_adder#(parameter N=4)(
  input logic[N-1:0] A, B,
  input logic CIN,
  output logic[N:0] result
);

 // Add code for carry lookahead adder 

task calculate_carry(input logic A, B, CIN, output logic G, P, COUT);
  G = A & B;
  P = A ^ B;
  COUT = G | (P & CIN);
endtask
logic [N-1:0] C, G, P;
calculate_carry(A[i], B[i], CIN, G[i], P[i], C[i]);
for (int i=1; i<N; i++) begin
  calculate_carry(A[i], B[i], C[i - 1], G[i], P[i], C[i]);
end

assign result = P ^ {C, CIN};
  
endmodule: carry_lookahead_adder
