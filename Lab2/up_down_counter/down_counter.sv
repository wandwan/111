// 4-bit down counter RTL code
module down_counter #(
  parameter WIDTH = 4
) (
  input logic clk,
  input logic clear,
  output logic [WIDTH-1:0] count
);
logic [WIDTH-1:0] cnt_value;
  // Down counter logic
  always @(posedge clk or posedge clear) begin
    if (clear == 1) begin
      cnt_value = 4'b1111; // Set count to 15 (highest value for 4-bit counter)
    end
    else begin
        cnt_value = cnt_value - 1; // Decrement count by 1
    end
  end
  assign count = cnt_value;

endmodule: down_counter