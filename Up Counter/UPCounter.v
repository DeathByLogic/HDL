module nBitCounter(count, clk, rst_n);
  parameter n = 7;

  output reg [n:0] count;
  input clk;
  input rst_n;

  // Set the initial value
  initial
    count = 0;

  // Increment count on clock
  always @(posedge clk or negedge rst_n)
    if (!rst_n)
      count = 0;
    else
      count = count + 1;

endmodule