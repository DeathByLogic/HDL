module DualSevenSegmentDriver(ssOut, bIn, CLK);
  output [6:0] ssOut;
  input [7:0] bIn;
  input CLK;

  // Current nibble to display on LED's
  reg [3:0] dNibble;

  // Select the upper or lower nibble depending on CLK
  always @(CLK)
    dNibble = CLK?bIn[7:4]:bIn[3:0];

  // Decode nibble into LED segments
  SevenSegmentDisplayDecoder SSDD(ssOut, dNibble);
endmodule