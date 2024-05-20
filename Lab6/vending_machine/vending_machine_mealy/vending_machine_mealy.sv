// Vending Machine RTL Code
module vending_machine_mealy( 
 input logic clk, rstn,  
 input logic N, D,
 output logic open);
 
 // State encoding and state variables
 parameter[3:0] CENTS_0=4'b0001, CENTS_5=4'b0010, CENTS_10=4'b0100, CENTS_15=4'b1000;
 logic[3:0] present_state, next_state; 

 // Local Variables for registering inputs N and D
 logic r_N, r_D;

 // Note : output open is not registered (i.e. no flipflop at output port open) in this example for students to compare moore and mealy machine waveform and see what is the different between mealy and moore
 // remember we learnt in class that mealy reacts immediately to change in input !!
 // Add flipflop for each input 'N' and 'D'
 // Sequential Logic for present state
 always_ff@(posedge clk) begin
  if(!rstn) begin

    // Student to Add Code
      r_N <= 1'b0;
      r_D <= 1'b0;
  end 
  else begin
    // Student to Add Code 
    r_N <= N;
    r_D <= D;
  end
 end
// Sequential Logic for present state
always_ff @(posedge clk) begin
  if (!rstn) begin
    present_state <= CENTS_0;
  end else begin
    present_state <= next_state;
  end
end


 // Combination Logic for Next State and Output
 always_comb begin 

  // Student to Add Code
  case (present_state)
        CENTS_0: begin
          if (r_N)      next_state = CENTS_5;
          else if (r_D) next_state = CENTS_10;
          else          next_state = CENTS_0;
          open = 1'b0;
        end
        
        CENTS_5: begin
          if (r_N)      next_state = CENTS_10;
          else if (r_D) next_state = CENTS_15;
          else          next_state = CENTS_5;
          open = 1'b0;
        end
         
        CENTS_10: begin
          if (r_N)      next_state = CENTS_15;
          else if (r_D) next_state = CENTS_0;
          else          next_state = CENTS_10; 
          open = r_D;
        end
          
        CENTS_15: begin  
          next_state = CENTS_0;
          open = 1'b1;
        end
        
        default: begin
          next_state = CENTS_0;
          open = 1'b0;  
        end
      endcase
 end
endmodule: vending_machine_mealy
