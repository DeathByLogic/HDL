module nBitAdder(f, cOut, a, b, cIn);
  parameter n = 7; 	

  output reg [n:0] f;
  output reg cOut;
  input [n:0] a;
  input [n:0] b;
  input cIn;

  always @(a, b, cIn)
    {cOut, f} = a + b + cIn;
endmodule