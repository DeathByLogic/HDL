LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
ENTITY TB_RAM IS
END TB_RAM;
 
ARCHITECTURE behavior OF TB_RAM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAM
	   GENERIC (
        DIN_WIDTH  : integer := 8;
        ADDR_WIDTH : integer := 5;
        ADDR_COUNT : integer := 32
		  );
      PORT(
         CLK	: IN  std_logic;
         RST	: IN  std_logic;
         Din	: IN  std_logic_vector(7 downto 0);
         Addr	: IN  std_logic_vector(4 downto 0);
         Wr_En : IN  std_logic;
         En 	: IN  std_logic;
         DOut	: OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK   : std_logic := '0';
   signal RST   : std_logic := '1';
   signal Din	 : std_logic_vector(7 downto 0) := (others => '0');
   signal Addr	 : std_logic_vector(4 downto 0) := (others => '0');
   signal Wr_En : std_logic := '0';
   signal En    : std_logic := '0';

 	--Outputs
   signal DOut  : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut : RAM
		PORT MAP (
			CLK => CLK,
			RST => RST,
			Din => Din,
			Addr => Addr,
			Wr_En => Wr_En,
			En => En,
			DOut => DOut
		);

   -- Clock process definitions
   CLK_process : process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
	-- Stimulate Control process
	stim_main : process
	begin
		wait for CLK_period * 10;	
		
		RST <= '0';
		
      wait for CLK_period * 10;
		
		En <= '1';
		
		wait for CLK_period * 112;

		En <= '0';
		
		wait for CLK_period * 16;
		
		RST <= '1';
		
		wait for CLK_period * 16;
		
		RST <= '0';
		
		En <= '1';
		
		wait;

	end process;
 
   -- Stimulate Write process
   stim_write : process
   begin		
      wait for CLK_period * 20;	
		
      for i in 0 to 31 loop
			Wr_En <= '1';
			
			Din  <= Din + 3;
			
			wait for CLK_period * 1;
			
			Wr_En <= '0';
			
			wait for clk_period * 2;
		end loop;

      wait;
   end process;
	
	-- Stimulate Read process
	stim_read : process
   begin		
      wait for CLK_period * 20;	

      loop
			Addr <= Addr + 7;
			
			wait for clk_period * 1;
		end loop;

      wait;
   end process;

end;
