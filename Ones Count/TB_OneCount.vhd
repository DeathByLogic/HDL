--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:25:59 10/15/2012
-- Design Name:   
-- Module Name:   D:/Users/Daniel/Working Folder/OneCount/TB_OneCount.vhd
-- Project Name:  OneCount
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: OneCount
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY TB_BitCounter IS
END TB_BitCounter;
 
ARCHITECTURE behavior OF TB_BitCounter IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BitCounter
    PORT(
         CLK : IN  std_logic;
         WrEn : IN  std_logic;
         Input : IN  std_logic_vector(9 downto 0);
         Count : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal WrEn : std_logic := '0';
   signal Input : std_logic_vector(9 downto 0) := "1010101010";

 	--Outputs
   signal Count : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BitCounter PORT MAP (
          CLK => CLK,
          WrEn => WrEn,
          Input => Input,
          Count => Count
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for CLK_period * 10;
		
		loop
			
			Input <= Input + 1;
			
			wait for CLK_period;
			
			WrEn <= '1';
		
			wait for CLK_period;
		
			WrEn <= '0';
					
			wait for CLK_period;
		end loop;

      wait;
   end process;

END;
