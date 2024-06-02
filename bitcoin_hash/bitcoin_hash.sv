`include "opt_sha256.sv"
module bitcoin_hash (input logic        clk, reset_n, start,
                     input logic [15:0] message_addr, output_addr,
                    output logic        done, mem_clk, mem_we,
                    output logic [15:0] mem_addr,
                    output logic [31:0] mem_write_data,
                     input logic [31:0] mem_read_data);

// Local variables for state transitions
enum logic [2:0] {IDLE, READ, PHASE_ONE, PREP_PHASE_TWO, PHASE_TWO, PREP_PHASE_THREE, PHASE_THREE, WRITE} state;

// Local variables for SHA PHASE 1
logic start_sha1 = 0;
logic [31:0] message_sha1[15:0];
logic [31:0] size_sha1;
logic [31:0] hin_sha1[7:0] = '{32'h5be0cd19, 32'h1f83d9ab, 32'h9b05688c, 32'h510e527f, 32'ha54ff53a, 32'h3c6ef372, 32'hbb67ae85, 32'h6a09e667};
logic [31:0] hout_sha1[7:0];
logic done_sha1;


// Local variables for SHA PHASE 2 and 3
logic start_sha2 = 0;
logic done_sha2;
logic [31:0] hin_sha2[7:0];

logic [31:0] hout_sha2_n0[7:0];         // Nonce 0
logic [31:0] message_sha2_n0[15:0];

logic [31:0] hout_sha2_n1[7:0];         // Nonce 1
logic [31:0] message_sha2_n1[15:0];

logic [31:0] hout_sha2_n2[7:0];         // Nonce 2
logic [31:0] message_sha2_n2[15:0];

logic [31:0] hout_sha2_n3[7:0];         // Nonce 3
logic [31:0] message_sha2_n3[15:0];

logic [31:0] hout_sha2_n4[7:0];         // Nonce 4
logic [31:0] message_sha2_n4[15:0];

logic [31:0] hout_sha2_n5[7:0];         // Nonce 5
logic [31:0] message_sha2_n5[15:0];

logic [31:0] hout_sha2_n6[7:0];         // Nonce 6
logic [31:0] message_sha2_n6[15:0];

logic [31:0] hout_sha2_n7[7:0];         // Nonce 7
logic [31:0] message_sha2_n7[15:0];

logic [31:0] hout_sha2_n8[7:0];         // Nonce 8
logic [31:0] message_sha2_n8[15:0];

logic [31:0] hout_sha2_n9[7:0];         // Nonce 9
logic [31:0] message_sha2_n9[15:0];

logic [31:0] hout_sha2_n10[7:0];         // Nonce 10
logic [31:0] message_sha2_n10[15:0];

logic [31:0] hout_sha2_n11[7:0];         // Nonce 11
logic [31:0] message_sha2_n11[15:0];

logic [31:0] hout_sha2_n12[7:0];         // Nonce 12
logic [31:0] message_sha2_n12[15:0];

logic [31:0] hout_sha2_n13[7:0];         // Nonce 13
logic [31:0] message_sha2_n13[15:0];

logic [31:0] hout_sha2_n14[7:0];         // Nonce 14
logic [31:0] message_sha2_n14[15:0];

logic [31:0] hout_sha2_n15[7:0];         // Nonce 15
logic [31:0] message_sha2_n15[15:0];


// Local variables for reading from and storing to memory
logic        cur_we;
logic [15:0] cur_addr;
logic [31:0] cur_write_data;
logic [ 7:0] j, i;
logic [31:0] message_orig[19:0];

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
    .message(message_orig[15:0]),
    .hin(hin_sha1),
    .hout(hout_sha1),
    .done(done_sha1)
);

// Module instantiations for SHA PHASE 2 and 3
opt_sha256 sha_phase_two_and_three_n0 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n0),
    .hin(hin_sha2),
    .hout(hout_sha2_n0),
    .done(done_sha2)
);

opt_sha256 sha_phase_two_and_three_n1 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n1),
    .hin(hin_sha2),
    .hout(hout_sha2_n1),
    .done()
);

opt_sha256 sha_phase_two_and_three_n2 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n2),
    .hin(hin_sha2),
    .hout(hout_sha2_n2),
    .done()
);

opt_sha256 sha_phase_two_and_three_n3 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n3),
    .hin(hin_sha2),
    .hout(hout_sha2_n3),
    .done()
);

opt_sha256 sha_phase_two_and_three_n4 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n4),
    .hin(hin_sha2),
    .hout(hout_sha2_n4),
    .done()
);

opt_sha256 sha_phase_two_and_three_n5 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n5),
    .hin(hin_sha2),
    .hout(hout_sha2_n5),
    .done()
);

opt_sha256 sha_phase_two_and_three_n6 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n6),
    .hin(hin_sha2),
    .hout(hout_sha2_n6),
    .done()
);

opt_sha256 sha_phase_two_and_three_n7 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n7),
    .hin(hin_sha2),
    .hout(hout_sha2_n7),
    .done()
);

opt_sha256 sha_phase_two_and_three_n8 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n8),
    .hin(hin_sha2),
    .hout(hout_sha2_n8),
    .done()
);

opt_sha256 sha_phase_two_and_three_n9 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n9),
    .hin(hin_sha2),
    .hout(hout_sha2_n9),
    .done()
);

opt_sha256 sha_phase_two_and_three_n10 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n10),
    .hin(hin_sha2),
    .hout(hout_sha2_n10),
    .done()
);

opt_sha256 sha_phase_two_and_three_n11 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n11),
    .hin(hin_sha2),
    .hout(hout_sha2_n11),
    .done()
);

opt_sha256 sha_phase_two_and_three_n12 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n12),
    .hin(hin_sha2),
    .hout(hout_sha2_n12),
    .done()
);

opt_sha256 sha_phase_two_and_three_n13 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n13),
    .hin(hin_sha2),
    .hout(hout_sha2_n13),
    .done()
);

opt_sha256 sha_phase_two_and_three_n14 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n14),
    .hin(hin_sha2),
    .hout(hout_sha2_n14),
    .done()
);

opt_sha256 sha_phase_two_and_three_n15 (
    .clk(clk),
    .reset_n(reset_n),
    .start(start_sha2),
    .message(message_sha2_n15),
    .hin(hin_sha2),
    .hout(hout_sha2_n15),
    .done()
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
                i <= 0;
                if (start) begin
                    state <= READ;
                end else begin
                    state <= IDLE;
                end
            end
            READ: begin
                if (j < 21) begin
                  if(j != 0) begin
                    message_orig[j-1] <= mem_read_data;
                  end
                  cur_addr <= cur_addr + 1;
                  j <= j + 1;
                  state <= READ;
                end else begin
                  j <= 0;
                  cur_addr <= message_addr;
                  state <= PHASE_ONE;
                  start_sha1 <= 1'b1;
                end
            end
            PHASE_ONE: begin
                start_sha1 <= 1'b0;
                if (done_sha1) begin
                    state <= PREP_PHASE_TWO;
                end else begin
                    state <= PHASE_ONE;
                end
            end
            PREP_PHASE_TWO: begin
                message_sha2_n0 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd0, message_orig[18:16]};
                message_sha2_n1 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd1, message_orig[18:16]};
                message_sha2_n2 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd2, message_orig[18:16]};
                message_sha2_n3 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd3, message_orig[18:16]};
                message_sha2_n4 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd4, message_orig[18:16]};
                message_sha2_n5 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd5, message_orig[18:16]};
                message_sha2_n6 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd6, message_orig[18:16]};
                message_sha2_n7 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd7, message_orig[18:16]};
                message_sha2_n8 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd8, message_orig[18:16]};
                message_sha2_n9 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd9, message_orig[18:16]};
                message_sha2_n10 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd10, message_orig[18:16]};
                message_sha2_n11 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd11, message_orig[18:16]};
                message_sha2_n12 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd12, message_orig[18:16]};
                message_sha2_n13 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd13, message_orig[18:16]};
                message_sha2_n14 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd14, message_orig[18:16]};
                message_sha2_n15 <= {32'd640, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, 32'd15, message_orig[18:16]};
                hin_sha2 <= hout_sha1;
                state <= PHASE_TWO;
                start_sha2 <= 1'b1;
            end
            PHASE_TWO: begin
                start_sha2 <= 1'b0;
                if (done_sha2) begin
                    state <= PREP_PHASE_THREE;
                end else begin
                    state <= PHASE_TWO;
                end
            end
            PREP_PHASE_THREE: begin
                message_sha2_n0 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n0};
                message_sha2_n1 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n1};
                message_sha2_n2 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n2};
                message_sha2_n3 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n3};
                message_sha2_n4 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n4};
                message_sha2_n5 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n5};
                message_sha2_n6 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n6};
                message_sha2_n7 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n7};
                message_sha2_n8 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n8};
                message_sha2_n9 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n9};
                message_sha2_n10 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n10};
                message_sha2_n11 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n11};
                message_sha2_n12 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n12};
                message_sha2_n13 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n13};
                message_sha2_n14 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n14};
                message_sha2_n15 <= {32'd256, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h00000000, 32'h80000000, hout_sha2_n15};
                hin_sha2 <= hin_sha1;
                state <= PHASE_THREE;
                start_sha2 <= 1'b1;
            end
            PHASE_THREE: begin
                start_sha2 <= 1'b0;
                if (done_sha2) begin
                    state <= WRITE;
                    cur_we <= 1;
                    i <= 0;
                end else begin
                    state <= PHASE_THREE;
                end
            end
            WRITE: begin
                if (i < 16) begin
                    cur_addr <= output_addr + i;
                    unique case (i)
                    0: cur_write_data <= hout_sha2_n0[0];
                    1: cur_write_data <= hout_sha2_n1[0];
                    2: cur_write_data <= hout_sha2_n2[0];
                    3: cur_write_data <= hout_sha2_n3[0];
                    4: cur_write_data <= hout_sha2_n4[0];
                    5: cur_write_data <= hout_sha2_n5[0];
                    6: cur_write_data <= hout_sha2_n6[0];
                    7: cur_write_data <= hout_sha2_n7[0];
                    8: cur_write_data <= hout_sha2_n8[0];
                    9: cur_write_data <= hout_sha2_n9[0];
                    10: cur_write_data <= hout_sha2_n10[0];
                    11: cur_write_data <= hout_sha2_n11[0];
                    12: cur_write_data <= hout_sha2_n12[0];
                    13: cur_write_data <= hout_sha2_n13[0];
                    14: cur_write_data <= hout_sha2_n14[0];
                    15: cur_write_data <= hout_sha2_n15[0];
                    endcase
                    i <= i + 1;
                    state <= WRITE;
                end else begin
                    cur_we <= 0;
                    done <= 1'b1;
                    state <= IDLE;
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
