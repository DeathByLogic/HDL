--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:54:43 11/25/2012
-- Design Name:   
-- Module Name:   D:/Users/Daniel/Working Folder/ModuleTesting/TB_FIFO.vhd
-- Project Name:  ModuleTesting
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: FIFO
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY TB_STD_FIFO IS
END TB_STD_FIFO;

ARCHITECTURE behavior OF TB_STD_FIFO IS 
	
	-- Component Declaration for the Unit Under Test (UUT)
	component STD_FIFO
		Generic (
			constant DATA_WIDTH  : positive := 8;
			constant FIFO_DEPTH	: positive := 16
		);
		port (
			CLK		: in std_logic;
			RST		: in std_logic;
			DataIn	: in std_logic_vector(7 downto 0);
			WriteEn	: in std_logic;
			ReadEn	: in std_logic;
			DataOut	: out std_logic_vector(7 downto 0);
			Full	: out std_logic;
			Empty	: out std_logic
		);
	end component;
	
	--Inputs
	signal CLK		: std_logic := '0';
	signal RST		: std_logic := '0';
	signal DataIn	: std_logic_vector(7 downto 0) := (others => '0');
	signal ReadEn	: std_logic := '0';
	signal WriteEn	: std_logic := '0';
	
	--Outputs
	signal DataOut	: std_logic_vector(7 downto 0);
	signal Empty	: std_logic;
	signal Full		: std_logic;
	
	-- Clock period definitions
	constant CLK_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: STD_FIFO
		PORT MAP (
			CLK		=> CLK,
			RST		=> RST,
			DataIn	=> DataIn,
			WriteEn	=> WriteEn,
			ReadEn	=> ReadEn,
			DataOut	=> DataOut,
			Full	=> Full,
			Empty	=> Empty
		);
	
	-- Clock process definitions
	CLK_process :process
	begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
	end process;
	
	-- Reset process
	rst_proc : process
	begin
	wait for CLK_period * 5;
		
		RST <= '1';
		
		wait for CLK_period * 5;
		
		RST <= '0';
		
		wait;
	end process;
	
	-- Write process
	wr_proc : process
		variable counter : unsigned (7 downto 0) := (others => '0');
	begin		
		wait for CLK_period * 20;

		for i in 1 to 32 loop
			counter := counter + 1;
			
			DataIn <= std_logic_vector(counter);
			
			wait for CLK_period * 1;
			
			WriteEn <= '1';
			
			wait for CLK_period * 1;
		
			WriteEn <= '0';
		end loop;
		
		wait for clk_period * 20;
		
		for i in 1 to 32 loop
			counter := counter + 1;
			
			DataIn <= std_logic_vector(counter);
			
			wait for CLK_period * 1;
			
			WriteEn <= '1';
			
			wait for CLK_period * 1;
			
			WriteEn <= '0';
		end loop;
		
		wait;
	end process;
	
	-- Read process
	rd_proc : process
	begin
		wait for CLK_period * 20;
		
		wait for CLK_period * 40;
			
		ReadEn <= '1';
		
		wait for CLK_period * 60;
		
		ReadEn <= '0';
		
		wait for CLK_period * 256 * 2;
		
		ReadEn <= '1';
		
		wait;
	end process;

END;
