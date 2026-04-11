library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity RegisterPlus is
  port (
    Load : in std_logic;
    Save : in std_logic;
    Save_Val : in unsigned(7 downto 0);

    Fetch : out unsigned(7 downto 0) := "00000000";
    Always : out unsigned(7 downto 0) := "00000000"
  );
end RegisterPlus;

architecture IMPL of RegisterPlus is
    signal memory : unsigned(7 downto 0) := "00000000";
begin

    process(Load, memory)
    begin
        if(Load = '1') then
            Fetch <= memory;
        else
            Fetch <= "00000000";
        end if;
    end process;

    process(Save, Save_Val)
    begin
        if(Save = '1') then
            memory <= Save_Val;
            Always <= Save_Val;
        end if;
    end process;

end IMPL;