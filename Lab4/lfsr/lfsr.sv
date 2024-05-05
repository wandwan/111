//RTL Model for Linear Feedback Shift Register
module lfsr
#(parameter N = 4) // Number of bits for LFSR
(
  input logic clk, reset, load_seed,
  input logic[N-1:0] seed_data,
  output logic lfsr_done,
  output logic[N-1:0] lfsr_data
);

logic [7:0][7:0] taps;
assign taps[0] = 8'b0000_0000;
assign taps[1] = 8'b0000_0011;
assign taps[2] = 8'b0000_0110;
assign taps[3] = 8'b0000_1100;
assign taps[4] = 8'b0001_0100;
assign taps[5] = 8'b0011_0000;
assign taps[6] = 8'b0110_0000;
assign taps[7] = 8'b1011_1000;

//student to add implementation for LFSR code 
logic [N-1:0] lfsr_reg;
logic [7:0] count;
always_ff @(posedge clk, negedge reset) begin
  if(~reset) begin
    lfsr_reg <= 0;
    count <= 0;
  end
  else if(load_seed) begin
    lfsr_reg <= seed_data;
    count <= 0;
  end
  else begin
    lfsr_reg <= {lfsr_reg[N-2:0], ^(lfsr_reg & taps[N-1][N-1:0])};
    // $display("and_out=%b, xor_out=%b, taps=%b, lsfr_reg=%b", (lfsr_reg[N-1] & taps[N-1][N-1:0]), ^(lfsr_reg[N-1] & taps[N-1][N-1:0]), taps[N-1][N-1:0], lfsr_reg);
  end
  count <= count + 1;
end
assign lfsr_done = &(count && ((1 << N) - 1));
assign lfsr_data = lfsr_reg;
 
endmodule: lfsr