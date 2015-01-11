module nBitCounter_TB;

   // Inputs
   reg clk;
   reg rst_n;

   // Outputs
   wire [7:0] count;

   // Instantiate the Unit Under Test (UUT)
   nBitCounter uut (
      .count(count), 
      .clk(clk), 
      .rst_n(rst_n)
   );

   initial begin
      // Initialize Inputs
      clk = 0;
      rst_n = 1;

      // Force Reset after delay
      #20 rst_n = 0;
      #25 rst_n = 1;
   end

   // Generate clock
   always
      #1 clk = !clk;

endmodule