module gray_code_to_binary_convertor #(parameter N = 4)( 
  input logic clk, rstn, 
  input logic[N-1:0] gray_value,
  output logic[N-1:0] binary_value);
  
  
  logic [$clog2(N):0][N-1:0] tmps;
  // Add code for gray code to binary conversion
  always_ff @(posedge clk or negedge rstn) begin
    if(~rstn) begin
      binary_value <= 0;
    end
    else begin
      binary_value[0] <= gray_value[0];
      tmps[0] <= gray_value ^ (gray_value >> 1);
      for(int i=1; i<$clog2(N); i=i+1) begin
        tmps[i] <= tmps[i-1] ^ (tmps[i-1] >> (1 << i));
    end
  end
  end
  
  assign binary_value = tmps[$clog2(N)-1];

endmodule: gray_code_to_binary_convertor
