// 4-bit up and down counter RTL code
module up_down_counter #(
  parameter WIDTH = 4
) (
  input logic clk,
  input logic clear,
  input logic select,
  output logic [WIDTH-1:0] count_value
);

  // Local variable declaration
  logic [WIDTH-1:0] up_count_value, down_count_value;

  // Instantiate up counter
  up_counter #(
    .WIDTH(WIDTH)
  ) up_counter_inst (
    .clk(clk),
    .clear(clear),
    .count(up_count_value)
  );

  // Instantiate down counter
  down_counter #(
    .WIDTH(WIDTH)
  ) down_counter_inst (
    .clk(clk),
    .clear(clear),
    .count(down_count_value)
  );

  // Instantiate 2-to-1 multiplexer
  mux_2x1 #(
    .WIDTH(WIDTH)
  ) mux_inst (
    .in0(up_count_value),
    .in1(down_count_value),
    .sel(select),
    .out(count_value)
  );

endmodule: up_down_counter