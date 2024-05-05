// D latching using always_comb
module d_latch (
  input logic d, e, reset,
  output logic q, q_bar
);

  logic a1, a2;
  always_comb begin
    a1 = ~d && e;
    a2 = d && e;
    q = ~(a1 || q_bar);
    q_bar = ~(a2 || q);
    end
    endmodule