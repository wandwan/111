module gray_code_to_binary_convertor #(parameter N = 4)( 
  input logic clk, rstn, 
  input logic[N-1:0] gray_value,
  output logic[N-1:0] binary_value);
  
  
function automatic [N-1:0] gray_to_binary(logic[N-1:0] gray_value);
  begin
    gray_to_binary = gray_value;
    for(int i=N-2; i>=0; i=i-1) begin
      gray_to_binary[i] = gray_to_binary[i] ^ gray_to_binary[i+1];
    end
  end
endfunction

  // Add code for gray code to binary conversion
  always_ff @(posedge clk or negedge rstn) begin
    if(~rstn) begin
      binary_value <= 0;
    end
    else begin
      binary_value <= gray_to_binary(gray_value);
    end
  end

endmodule: gray_code_to_binary_convertor
