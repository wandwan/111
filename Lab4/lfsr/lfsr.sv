//RTL Model for Linear Feedback Shift Register
module lfsr
#(parameter N = 4) // Number of bits for LFSR
(
  input logic clk, reset, load_seed,
  input logic[N-1:0] seed_data,
  output logic lfsr_done,
  output logic[N-1:0] lfsr_data
);

//student to add implementation for LFSR code 
logic [N-1:0] lfsr_reg;
logic [N-1:0] count = 0;
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
    case(N):
      2: lfsr_reg <= {lfsr_reg[0],lfsr_reg[0] ^ lfsr_reg[1]};
      3: lfsr_reg <= {lfsr_reg[1:0], lfsr_reg[2] ^ lfsr_reg[1]};
      4: lfsr_reg <= {lfsr_reg[2:0], lfsr_reg[3] ^ lfsr_reg[2]};
      5: lfsr_reg <= {lfsr_reg[3:0], lfsr_reg[4] ^ lfsr_reg[2]};
      6: lfsr_reg <= {lfsr_reg[4:0], lfsr_reg[5] ^ lfsr_reg[4]};
      7: lfsr_reg <= {lfsr_reg[5:0], lfsr_reg[6] ^ lfsr_reg[5]};
      8: lfsrc_reg <= {lfsr_reg[6:0], lfsr_reg[7] ^ lfsr_reg[5] ^ lfsr_reg[4] ^ lfsr_reg[3]};
      default: lfsr_reg <= lfsr_reg;
    endcase
    count <= count + 1;
  end
end
assign lfsr_done = count == ((1 << N) - 2);
assign lfsr_data = lfsr_reg;
 
endmodule: lfsr