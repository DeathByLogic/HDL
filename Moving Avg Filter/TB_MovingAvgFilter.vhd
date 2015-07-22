LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.math_real.ALL;
USE ieee.numeric_std.ALL;

 
ENTITY TB_MovingAvgFilter IS
END TB_MovingAvgFilter;
 
ARCHITECTURE behavior OF TB_MovingAvgFilter IS 
 
-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT MovingAvgFilter
		PORT(
			Clock		: IN  std_logic;
			Reset		: IN  std_logic;
			WriteEn	: IN  std_logic;
			DataIn	: IN  std_logic_vector (7 downto 0);
			DataOut	: OUT std_logic_vector (7 downto 0)
		);
	END COMPONENT;
    

   --Inputs
   signal Clock	: std_logic := '0';
   signal Reset	: std_logic := '0';
   signal WriteEn	: std_logic := '0';
   signal DataIn	: std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal DataOut : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MovingAvgFilter PORT MAP (
          Clock	=> Clock,
          Reset	=> Reset,
          WriteEn	=> WriteEn,
          DataIn	=> DataIn,
          DataOut	=> DataOut
        );

   -- Clock process definitions
   CLK_process :process
   begin
		Clock <= '0';
		wait for CLK_period/2;
		Clock <= '1';
		wait for CLK_period/2;
   end process;
 
	-- Reset process
	rst_proc : process
	begin
	wait for CLK_period * 5;
		
		Reset <= '1';
		
		wait for CLK_period * 5;
		
		Reset <= '0';
		
		wait;
	end process;

   -- Write process
   wr_proc : process
		variable counter : unsigned (7 downto 0) := (others => '0');
		variable offset  : unsigned (7 downto 0) := (others => '0');
		
		variable seed1 : positive := 432345343;
		variable seed2 : positive := 234563452;
		
		variable rand  : real := 0.0;
		variable mult	: real := 0.0;
   begin
		
		wait for CLK_period * 20;
		
		loop
			counter := counter + X"10";
			mult := mult + 5.0;

			for i in 1 to 64 loop
				-- Generate random real number
				uniform(seed1, seed2, rand);
				
				-- Convert the random number into an integer between 0 and 10
				offset := to_unsigned(integer(trunc(rand * mult)), DataIn'Length);
				
				-- Add offset to center point and write into filter
				DataIn <= std_logic_vector(counter + offset);
				
				wait for CLK_period * 1;
				
				WriteEn <= '1';
				
				wait for CLK_period * 1;
			
				WriteEn <= '0';
			end loop;
			
			wait for clk_period  * 10;
			
		end loop;
		
		wait;
   end process;

END;
