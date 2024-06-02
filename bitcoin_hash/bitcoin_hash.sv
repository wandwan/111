module bitcoin_hash (input logic        clk, reset_n, start,
                     input logic [15:0] message_addr, output_addr,
                    output logic        done, mem_clk, mem_we,
                    output logic [15:0] mem_addr,
                    output logic [31:0] mem_write_data,
                     input logic [31:0] mem_read_data);

// Local variables for SHA PHASE 1
logic start_sha1 = 0;
logic [31:0] message_sha1[15:0];
logic [31:0] size_sha1;
logic [31:0] hin_sha1[7:0] = '{32'h6a09e667, 32'hbb67ae85, 32'h3c6ef372, 32'ha54ff53a, 32'h510e527f, 32'h9b05688c, 32'h1f83d9ab, 32'h5be0cd19};
logic [31:0] hout_sha1[7:0];
logic done_sha1;

// Local variables for state transitions
enum logic [2:0] {IDLE, READ, PHASE_ONE, PHASE_TWO, PHASE_THREE} state;

// Local variables for storing final hash values per nonce
parameter num_nonces = 16;
logic [31:0] hout[num_nonces];

// Local variables for reading from and storing to memory
logic        cur_we;
logic [15:0] cur_addr;
logic [31:0] cur_write_data;
logic [ 7:0] j;

// Logic for continuously assigning memory addresses to read and write to data
assign mem_clk = clk;
assign mem_addr = cur_addr;
assign mem_we = cur_we;
assign mem_write_data = cur_write_data;


// Module instantiation of SHA PHASE 1
opt_sha256 sha_phase_one (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha1),
    .message(message_sha1),
    .hin(hin_sha1),
    .hout(hout_sha1),
    .done(done_sha1)
);


// State machine logic for performing bitcoin hashing
always_ff @(posedge clk, negedge reset_n) begin : bitcoin_hashing
    if (!reset_n) begin
        state <= IDLE;
        done <= 1'b0;
    end else begin
        case (state)
            //
            IDLE: begin
                done <= 1'b0;
                cur_we <= 1'b0;
                cur_addr <= message_addr;
                j <= 0;
                if (start) begin
                    state <= READ;
                end else begin
                    state <= IDLE;
                end
            end
            READ: begin
                if (j < 17) begin
                  if(j != 0) begin
                    message_sha1[j-1] <= mem_read_data;
                  end
                  cur_addr <= cur_addr + 1;
                  j <= j + 1;
                  state <= READ;
                end else begin
                  j <= 0;
                  cur_addr <= message_addr;
                  state <= PHASE_ONE;
                end
            end
            PHASE_ONE: begin
                start_sha1 <= 1'b1;
                if (done_sha1) begin
                    state <= IDLE;
                    done <= 1'b1;
                end else begin
                    state <= PHASE_ONE;
                end
            end
            default: begin
                state <= IDLE;
                done <= 1'b0;
            end
        endcase
    end
end




endmodule
