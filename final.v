module collatz_conjecture(
  input [15:0] sw,
  input clk,
  output [6:0] seg,
  output [3:0] an
  );

  wire reg_enable, clk_out, clock_out, sec_clock_out, reg_clock;
  wire [12:0] reg_out, start_mux_to_reg, BCDtoLED_out, add_out1, add_out2, add_out, mul_div_mux_out;
  wire [6:0] seg1, seg2, seg3, seg4;
  wire [3:0] ones, tens, hundreds, thousands;

  wire start = sw[15];
  wire pause = sw[14];
  wire reset = sw[13];
  wire [12:0] start_num = sw[12:0];

  mux2v #(13) start_mux(start_mux_to_reg, start_num, mul_div_mux_out, start);  // chooses between start number and cycling number - sends to register
  register #(13) main_reg(reg_out, start_mux_to_reg, reg_clock, reg_enable, reset);  // register to store cycling number
  mux2v #(13) BCDtoLED_mux(BCDtoLED_out, start_num, reg_out, start);  // chooses between start number number and cycling number - sends to display
  enable_bit_selector ebs(reg_enable, reg_out, pause);  // logic to enable register based on pause switch and current number in register

  // n/2
  wire [12:0] divide = {1'b0, reg_out[12:1]};

  // 3n+1
  adder add1(add_out1, reg_out, reg_out);
  adder add2(add_out2, add_out1, reg_out);
  adder add3(add_out, add_out2, 13'b1);

  // Choose n/2 or 3n+1 depending if number is even or odd respectively
  mux2v #(13) mul_div_mux(mul_div_mux_out, divide, add_out, reg_out[0]);

  // decimal digit decorder with outputs split to a BCDToLED decoder for each anode
  wire [15:0] binary = {3'b0, BCDtoLED_out};
  DecimalDigitDecoder ddd(binary, , thousands, hundreds, tens, ones);
  BCDToLED ones_BTL(ones, seg1);
  BCDToLED tens_BTL(tens, seg2);
  BCDToLED hundreds_BTL(hundreds, seg3);
  BCDToLED thousands_BTL(thousands, seg4);

  // anode selection masks
  wire [3:0] an1 = 4'b1110;
  wire [3:0] an2 = 4'b1101;
  wire [3:0] an3 = 4'b1011;
  wire [3:0] an4 = 4'b0111;
  
  clk_wiz clock1(clk, clk_out);  // 5Mhz clock
  clock_divider clock2(clk_out, clock_out);  // 5Mhz to 500Hz clock divider - used to select anode
  clock_divider #(1) clock3(clock_out, sec_clock_out);  // 500Hz to 250Hz clock divider - used to select anode
  clock_divider #(250) clock4(clock_out, reg_clock); // 500Hz to 1Hz clock divider - used to update register
  
  wire [1:0] select = {clock_out, sec_clock_out};  // concatenation of 500Hz and 250Hz clocks to switch between all 4 anodes
  mux4v #(7) seg_mux(seg, seg1, seg2, seg3, seg4, select);
  mux4v #(4) an_mux(an, an1, an2, an3, an4, select);

endmodule // collatz_conecture

