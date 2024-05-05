// Barrel Shifter RTL Model
`include "mux_2x1_behavioral.sv"
module barrel_shifter (
  input logic select,  // select=0 shift operation, select=1 rotate operation
  input logic direction, // direction=0 right move, direction=1 left move
  input logic[1:0] shift_value, // number of bits to be shifted (0, 1, 2 or 3)
  input logic[3:0] din,
  output logic[3:0] dout
);



// Students to add code for barrel shifter
wire [1:0][3:0] left_shifted, right_shifted, mux_out;
always_comb begin
  left_shifted[0] = din << shift_value;
  left_shifted[1] = din << shift_value | din >> (4-shift_value);
  right_shifted[0] = din >> shift_value;
  right_shifted[1] = din >> shift_value | din << (4-shift_value);
end
genvar i;
generate
  for(i=0; i<4; i=i+1) begin: left_shift
    mux_2x1 l0 mux_2x1_inst(
      .in0(left_shifted[0][i]),
      .in1(left_shifted[1][i]),
      .sel(select),
      .out(mux_out[1][i])
    );
    mux_2x1 r0 mux_2x1_inst(
      .in0(right_shifted[0][i]),
      .in1(right_shifted[1][i]),
      .sel(select),
      .out(mux_out[0][i])
    );
    mux_2x1 m0 mux_2x1_inst(
      .in0(mux_out[0][i]),
      .in1(mux_out[1][i]),
      .sel(direction),
      .out(dout[i])
    );
  end
endgenerate

endmodule: barrel_shifter


