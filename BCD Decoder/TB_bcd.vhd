--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:49:08 12/09/2013
-- Design Name:   
-- Module Name:   D:/Users/Daniel/Working Folder/FPGA Module Testing/TB_bcd.vhd
-- Project Name:  ModuleTesting
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bcd
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
USE ieee.numeric_std.ALL;
 
ENTITY TB_bcd IS
END TB_bcd;
 
ARCHITECTURE behavior OF TB_bcd IS 
 
   -- Component Declaration for the Unit Under Test (UUT)
   component bcd
      port(
         number   : in  std_logic_vector(7 downto 0);
         hundreds : out std_logic_vector(3 downto 0);
         tens     : out std_logic_vector(3 downto 0);
         ones     : out std_logic_vector(3 downto 0)
      );
   end component;
   
   --Inputs
   signal number   : std_logic_vector(7 downto 0) := (others => '0');

    --Outputs
   signal hundreds : std_logic_vector(3 downto 0);
   signal tens     : std_logic_vector(3 downto 0);
   signal ones     : std_logic_vector(3 downto 0);
 
BEGIN
 
   -- Instantiate the Unit Under Test (UUT)
   uut: bcd
      port map (
         number   => number,
         hundreds => hundreds,
         tens     => tens,
         ones     => ones
      );

   -- Stimulus process
   stim_proc: process
   begin      
      loop
         number <= std_logic_vector(unsigned(number) + 1);
         
         wait for 10 ns;
      end loop;
      
      wait;
   end process;

end;
