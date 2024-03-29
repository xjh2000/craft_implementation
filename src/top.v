`timescale 1ns / 1ps

module top (
    input wire CLK100MHZ,
    input wire CPU_RESETN,
    output LED
);
  parameter CLK_FREQUENCY = 100_000_000;

  wire [8-1:0] round = 8'h00;
  wire [128-1:0] key;
  wire [64-1:0] tweak;
  wire [64-1:0] TK;
  reg flag;

  wire [7:0] rc;

  assign key   = 128'h27a6_781a_43f3_64bc_9167_08d5_fbb5_aefe;
  assign tweak = 64'h54cd_94ff_d067_0a58;

  assign LED   = flag;


  always @(posedge CLK100MHZ) begin
    if (TK == 64'h736BECE593946EE4) begin
      flag <= 1;
    end else begin
      flag <= 0;
    end
  end

  // (* dont_touch = "yes" *) craft_key_schedule key_schedule (
  //     .key(key),
  //     .tweak(tweak),
  //     .r(round),
  //     .TK(TK)
  // );

  // (* dont_touch = "yes" *) craft_round_constants craft_round_constants_isnt (
  //     .clk(CLK100MHZ),
  //     .rst(CPU_RESETN),
  //     .rc (rc)
  // );

  // reg  [15:0] din = 16'h4567;
  // wire [15:0] dout;

  // (* dont_touch = "yes" *) craft_sbox craft_sbox_inst (
  //     .din (din),
  //     .dout(dout)
  // );

  // reg  [63:0] r_din = 64'h5734F006D8D88A3E;
  // reg  [63:0] r_tk = 64'h736BECE593946EE4;
  // reg  [ 7:0] r_rc = 8'h11;
  // wire [63:0] r_dout;

  // (* dont_touch = "yes" *) craft_round craft_round_inst (
  //     .din (r_din),
  //     .tk  (r_tk),
  //     .rc  (r_rc),
  //     .dout(r_dout)
  // );

  reg [63:0] plaintext = 64'h5734F006D8D88A3E;
  reg [63:0] tweak = 64'h54CD94FFD0670A58;
  reg [127:0] key = 128'h27a6_781a_43f3_64bc_9167_08d5_fbb5_aefe;
  wire done;
  wire [63:0] ciphertext;

  (* dont_touch = "yes" *) craft_encrypt craft_encrypt_inst (
      .clk(CLK100MHZ),
      .rst_n(CPU_RESETN),
      .plaintext(plaintext),
      .tweak(tweak),
      .key(key),
      .done(done),
      .ciphertext(ciphertext)
  );

endmodule
