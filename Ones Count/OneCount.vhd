library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BitCounter is
	Generic (
		INPUT_WIDTH : integer := 10;
		COUNT_WIDTH : integer := 4;
		COUNT_TYPE  : STD_LOGIC := '0'
	);
	Port (
		CLK	: in   STD_LOGIC;
		WrEn	: in   STD_LOGIC;
		Input	: in   STD_LOGIC_VECTOR (INPUT_WIDTH - 1 downto 0);
		Count : out  STD_LOGIC_VECTOR (COUNT_WIDTH - 1 downto 0)
	);
end BitCounter;

architecture Behavioral of BitCounter is

begin

	process (clk)
		variable Count_i : STD_LOGIC_VECTOR (Count'Range) := (others => '0');
	begin
		if rising_edge(clk) then
			if WrEn = '1' then
				Count_i := (others => '0');
			
				for i in Input'Range loop
					if Input(i) = COUNT_TYPE then
						Count_i := Count_i + 1;
					end if;
				end loop;
			end if;
			
			Count <= Count_i;
			
		end if;
	end process;

end Behavioral;

