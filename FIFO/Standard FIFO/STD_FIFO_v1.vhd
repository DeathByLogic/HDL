library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
entity STD_FIFO is
	Generic (
		constant DATA_WIDTH  : positive := 8;
		constant FIFO_DEPTH	: positive := 256  -- greater than or equal to 4 if Almost_Full is wanted
	);
	Port ( 
		CLK		    : in  STD_LOGIC;
		RST		    : in  STD_LOGIC;
		WriteEn	    : in  STD_LOGIC;
		DataIn	    : in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
		ReadEn	    : in  STD_LOGIC;
		DataOut	    : out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
		Empty	    : out STD_LOGIC;
		Almost_Full	: out STD_LOGIC;
		Full	    : out STD_LOGIC
	);
end STD_FIFO;
 
architecture Behavioral of STD_FIFO is

type FIFO_Memory is array (0 to FIFO_DEPTH - 1) of STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
signal Memory : FIFO_Memory;

signal Head           : natural range 0 to FIFO_DEPTH - 1;
signal Tail           : natural range 0 to FIFO_DEPTH - 1;
signal Next_Head      : natural range 0 to FIFO_DEPTH - 1;
signal Next_Tail      : natural range 0 to FIFO_DEPTH - 1;
signal Next_Next_Head : natural range 0 to FIFO_DEPTH - 1;

signal Looped : boolean;


signal fifo_control : std_logic_vector(1 downto 0);

 
begin

fifo_control <= ReadEn & WriteEn;
 
Next_Tail <= 0 when (Tail = FIFO_DEPTH - 1) else
             Tail + 1;
             
Next_Head <= 0 when (Head = FIFO_DEPTH - 1) else
             Head + 1;
             
Next_Next_Head <= 0 when (Next_Head = FIFO_DEPTH - 1) else
                  Next_Head + 1;               

DataOut   <= Memory(Tail) when Head /= Tail else
             (others => '1');

Full      <= '1' when Next_Head = Tail else
             '0';
             
Almost_Full <= '1' when Next_Next_Head = Tail else
               '0';

Empty     <= '1' when Head = Tail else
             '0';
              
-- Memory Pointer Process
fifo_proc : process (CLK)
	begin
		if rising_edge(CLK) then
			if RST = '1' then
				Head <= 0;
				Tail <= 0;
			else
                case fifo_control is  -- ReadEn & WriteEn
                    when "00" => -- not read, not write
                        -- do nothing
                    when "01" => -- not read, WRITE 
                        if Next_Head /= Tail then  -- it is not full
                            Memory(Head) <= DataIn;
                            Head <= Next_Head;
                        end if;
                    when "10" => -- READ, not write
                        if Head /= Tail then  -- it is not empty
                            Tail <= Next_Tail;
                        end if;    
                    when "11" => -- READ, WRITE
                        if Head = Tail then -- just write because it is empty
                            Memory(Head) <= DataIn;
                            Head <= Next_Head;
                        else                -- it is full or half full, write and read
                            Memory(Head) <= DataIn;
                            Head <= Next_Head;
                            Tail <= Next_Tail;
                        end if;
                    when others =>
                end case;
            end if;
        end if;
	end process;
		
end Behavioral;
