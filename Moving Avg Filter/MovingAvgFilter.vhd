library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MovingAvgFilter is
	Generic (
		constant DATA_WIDTH		: positive := 8;						-- Width of data input and output bus
		constant FILTER_DEPTH	: positive := 4							-- Depth of filter is 2^n samples
	);
	Port ( 
		Clock		: in  STD_LOGIC;									-- Clock input
		Reset		: in  STD_LOGIC;									-- Reset input
		WriteEn	: in  STD_LOGIC;										-- Active high write enable
		DataIn	: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);		-- Data input bus
		DataOut	: out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0)		-- Filtered data output bus
	);
end MovingAvgFilter;

architecture Behavioral of MovingAvgFilter is

	component RAM
		generic (
			constant DATA_WIDTH		: integer := DATA_WIDTH;
			constant ADDRESS_WIDTH	: integer := FILTER_DEPTH
		);
		port (
			Clock		: IN  std_logic;
			Reset		: IN  std_logic;
			Enable	: IN  std_logic;
			WriteEn	: IN  std_logic;
			Datain	: IN  std_logic_vector (DATA_WIDTH - 1 downto 0);
			Address	: IN  std_logic_vector (FILTER_DEPTH - 1 downto 0);
			DataOut	: OUT std_logic_vector (DATA_WIDTH - 1 downto 0)
		);
	end component;
	
	signal Address 	: std_logic_vector (FILTER_DEPTH - 1 downto 0);
	signal OldestData	: std_Logic_vector (DATA_WIDTH - 1 downto 0);

begin

	-- RAM for storing data bytes
	filter_ram : RAM
		PORT MAP(
			Clock		=> Clock,
			Reset		=> Reset,
			Enable	=> '1',
			WriteEn	=> WriteEn,
			Datain	=> DataIn,
			Address	=> Address,
			DataOut	=> OldestData
		);
	
	-- Filter process
	filter_proc : process (Clock)
		variable Sum : unsigned (DATA_WIDTH + FILTER_DEPTH - 1 downto 0);
	begin
		if rising_edge(Clock) then
			if (Reset = '1') then
				-- Reset Address and Sum on reset
				Address <= (others => '0');
				
				Sum := (others => '0');
			else
				if (WriteEn = '1') then
					-- Add the new byte and subtract the oldest byte from the sum
					Sum := Sum + unsigned(DataIn) - unsigned(OldestData);
					
					-- Caculate the average (Sum / FILTER_DEPTH)
					DataOut <= std_logic_vector(Sum(Sum'High downto FILTER_DEPTH));
					
					-- Increment the address to save/read the next byte
					Address <= std_logic_vector(unsigned(Address) + 1);
				end if;
			end if;
		end if;
	end process;

end Behavioral;
