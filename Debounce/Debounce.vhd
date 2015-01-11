library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Debounce is
  Port (
    CLK : in  STD_LOGIC;
    x : in  STD_LOGIC;
    DBx : out  STD_LOGIC
  );
end Debounce;

architecture Behavioral of Debounce is
  type State_Type is (S0, S1);
  signal State : State_Type := S0;

  signal DPB, SPB : STD_LOGIC;
  signal DReg : STD_LOGIC_VECTOR (7 downto 0);
begin
  process (CLK, x)
    variable SDC : integer;
    constant Delay : integer := 50000;
  begin
    if CLK'Event and CLK = '1' then
      -- Double latch input signal
      DPB <= SPB;
      SPB <= x;

      case State is
        when S0 =>
          DReg <= DReg(6 downto 0) & DPB;

          SDC := Delay;

          State <= S1;
        when S1 =>
          SDC := SDC - 1;

          if SDC = 0 then
            State <= S0;
          end if;
        when others =>
          State <= S0;
      end case;

      if DReg = X"FF" then
        DBx <= '1';
      elsif DReg = X"00" then
        DBx <= '0';
      end if;
    end if;
  end process;
end Behavioral;