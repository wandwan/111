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
logic [3:0] mux_in;
logic [3:0] mux_out;
logic [3:0] final_out;
logic [2:0] select_out;
mux_2x1 select_0(
  .in0(0),
  .in1(mux_in[0]),
  .sel(select),
  .out(select_out[0])
);
mux_2x1 select_1(
  .in0(0),
  .in1(mux_in[1]),
  .sel(select),
  .out(select_out[1])
);
mux_2x1 lvl1_1(
  .in0(mux_in[0]),
  .in1(mux_in[2]),
  .sel(shift_value[1]),
  .out(mux_out[0])
);

mux_2x1 lvl1_2(
  .in0(mux_in[1]),
  .in1(mux_in[3]),
  .sel(shift_value[1]),
  .out(mux_out[1])
);
mux_2x1 lvl1_3(
  .in0(mux_in[2]),
  .in1(select_out[0]),
  .sel(shift_value[1]),
  .out(mux_out[2])
);

mux_2x1 lvl1_4(
  .in0(mux_in[3]),
  .in1(select_out[1]),
  .sel(shift_value[1]),
  .out(mux_out[3])
);

mux_2x1 select_2(
  .in0(0),
  .in1(mux_out[0]),
  .sel(select),
  .out(select_out[2])
);

mux_2x1 lvl2_1(
  .in0(mux_out[0]),
  .in1(mux_out[1]),
  .sel(shift_value[0]),
  .out(final_out[0])
);

mux_2x1 lvl2_2(
  .in0(mux_out[1]),
  .in1(mux_out[2]),
  .sel(shift_value[0]),
  .out(final_out[1])
);
mux_2x1 lvl2_3(
  .in0(mux_out[2]),
  .in1(mux_out[3]),
  .sel(shift_value[0]),
  .out(final_out[2])
);
mux_2x1 lvl2_4(
  .in0(mux_out[3]),
  .in1(select_out[2]),
  .sel(shift_value[0]),
  .out(final_out[3])
);

always_comb begin 
  if(direction == 0) begin
    mux_in = din;
    dout = final_out;
  end
  else begin
    mux_in = {din[0], din[1], din[2], din[3]};
    dout = {final_out[0], final_out[1], final_out[2], final_out[3]};
  end
  
end



endmodule: barrel_shifter


