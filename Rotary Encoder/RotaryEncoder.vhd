library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Knob is
  Port (
    CLK : in  STD_LOGIC;
    RST : in  STD_LOGIC;
    A : in  STD_LOGIC;
    B : in  STD_LOGIC;
    Direction : out  STD_LOGIC;
    Count : out  STD_LOGIC := '0'
  );
end Knob;

architecture Behavioral of Knob is
  type State_Type is (
    CW_A, CW_B, CW_C, CW_D,
    CCW_A, CCW_B, CCW_C, CCW_D
  );

  signal PresentState, NextState : State_Type := CW_A;

  constant CCW : STD_LOGIC := '0';
  constant CW : STD_LOGIC := '1';
begin
  process (CLK)
  begin
    if CLK'Event and CLK = '1' then
      if RST = '1' then
        PresentState <= CW_A;
      else
        PresentState <= NextState;
      end if;
    end if;
  end process;

  process (A, B, PresentState)
    begin
      case PresentState is
       when CW_A =>
        if A = '0' and B = '1' then
          NextState <= CW_B;
        elsif A = '1' and B = '0' then
          NextState <= CCW_D;
        else
          NextState <= PresentState;
        end if;
      when CW_B =>
        if A = '0' and B = '0' then
          NextState <= CW_C;
        elsif A = '1' and B = '1' then
          NextState <= CCW_A;
        else
          NextState <= PresentState;
        end if;
      when CW_C =>
        if A = '1' and B = '0' then
          NextState <= CW_D;
        elsif A = '0' and B = '1' then
          NextState <= CCW_B;
        else
          NextState <= PresentState;
        end if;
      when CW_D =>
        if A = '1' and B = '1' then
          NextState <= CW_A;
        elsif A = '0' and B = '0' then
          NextState <= CCW_C;
        else
          NextState <= PresentState;
        end if;
      when CCW_A =>
        if A = '0' and B = '1' then
          NextState <= CW_B;
        elsif A = '1' and B = '0' then
          NextState <= CCW_D;
        else
          NextState <= PresentState;
        end if;
      when CCW_B =>
        if A = '0' and B = '0' then
          NextState <= CW_C;
        elsif A = '1' and B = '1' then
          NextState <= CCW_A;
        else
          NextState <= PresentState;
        end if;
      when CCW_C =>
        if A = '1' and B = '0' then
          NextState <= CW_D;
        elsif A = '0' and B = '1' then
          NextState <= CCW_B;
        else
          NextState <= PresentState;
        end if;
      when CCW_D =>
        if A = '1' and B = '1' then
          NextState <= CW_A;
        elsif A = '0' and B = '0' then
          NextState <= CCW_C;
        else
          NextState <= PresentState;
        end if;
       when others =>
         NextState <= CW_A;
    end case;
  end process;

  Direction <= '1' when PresentState = CW_A or
    PresentState = CW_B or PresentState = CW_C or
    PresentState = CW_D else '0';
  Count <= '1' when PresentState = CW_B or
    PresentState = CW_C or PresentState = CCW_B or
    PresentState = CCW_C else '0';
end Behavioral;