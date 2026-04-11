library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity Decoder3bit is
  port (
    Disable : in std_logic;
    BitIn : in std_logic_vector(2 downto 0) := "000";
    SelectOut : out std_logic_vector(1 to 8) := "00000000"
  );
end Decoder3bit;

architecture IMPL of Decoder3bit is
begin

    process(BitIn, Disable)
    begin
        case(to_integer(unsigned(BitIn))) is
            when 1 =>
                SelectOut <= "01000000";
            when 2 =>
                SelectOut <= "00100000";
            when 3 =>
                SelectOut <= "00010000";
            when 4 =>
                SelectOut <= "00001000";
            when 5 =>
                SelectOut <= "00000100";
            when 6 =>
                SelectOut <= "00000010";
            when 7 =>
                SelectOut <= "00000001";
            when others => -- weird case
                SelectOut <= "10000000";
        end case;

        if Disable = '1' then
            SelectOut <= "00000000";
        end if;
    end process;

end IMPL;