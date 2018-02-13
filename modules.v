module enable_bit_selector(enable_bit, bits, pause_sw);
  output enable_bit;
  input [12:0] bits;
  input pause_sw;
  
  //wire top, mid;
  wire top_and1_out, top_and_out, mid_and1_out, mid_and_out, bot_and1_out, bot_and_out, top_mid_out;

  // reg_out[12:1] = 1, reg_out[0] = 1, pause = 0
  assign top_and_bits = |bits[12:1];
  and top_and1(top_and1_out, top_and_bits, bits[0]);
  and top_and(top_and_out, top_and1_out, ~pause_sw);

  // reg_out[12:1] = 0, reg_out[0] = 0, pause = 0
  assign mid_and_bits = ~|bits[12:1];
  and mid_and1(mid_and1_out, mid_and_bits, ~bits[0]);
  and mid_and(mid_and_out, mid_and1_out, ~pause_sw);

  // reg_out[12:1] = 1, reg_out[0] = 0, pause = 0
  assign bot_and_bits = |bits[12:1];
  and bot_and1(bot_and1_out, ~bits[0], ~pause_sw);
  and bot_and(bot_and_out, bot_and1_out, bot_and_bits);

  // or all the sections together
  or top_or_mid(top_mid_out, top_and_out, mid_and_out);
  or top_mid_or_bot(enable_bit, top_mid_out, bot_and_out);

endmodule // enable_bit_selector


module adder(out, in1, in2);
  output [12:0] out;
  input [12:0] in1, in2;

  wire sum0, sum1, sum2, sum3, sum4, sum5, sum6, sum7, sum8, sum9, sum10, sum11, sum12;
  wire cout0, cout1, cout2, cout3, cout4, cout5, cout6, cout7, cout8, cout9, cout10, cout11;

  fulladder fa0(sum0, cout0, in1[0], in2[0], 1'b0);
  fulladder fa1(sum1, cout1, in1[1], in2[1], cout0);
  fulladder fa2(sum2, cout2, in1[2], in2[2], cout1);
  fulladder fa3(sum3, cout3, in1[3], in2[3], cout2);
  fulladder fa4(sum4, cout4, in1[4], in2[4], cout3);
  fulladder fa5(sum5, cout5, in1[5], in2[5], cout4);
  fulladder fa6(sum6, cout6, in1[6], in2[6], cout5);
  fulladder fa7(sum7, cout7, in1[7], in2[7], cout6);
  fulladder fa8(sum8, cout8, in1[8], in2[8], cout7);
  fulladder fa9(sum9, cout9, in1[9], in2[9], cout8);
  fulladder fa10(sum10, cout10, in1[10], in2[10], cout9);
  fulladder fa11(sum11, cout11, in1[11], in2[11], cout10);
  fulladder fa12(sum12, , in1[12], in2[12], cout11);

  assign out = {sum12, sum11, sum10, sum9, sum8, sum7, sum6, sum5, sum4, sum3, sum2, sum1, sum0};

endmodule // adder
