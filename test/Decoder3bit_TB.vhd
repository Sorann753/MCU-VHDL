library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Decoder3bit_TB is
end entity;

architecture TB of Decoder3bit_TB is

    signal CLK : std_logic := '0';
    
    signal Disable : std_logic := '0';
    signal BitIn : std_logic_vector(2 downto 0) := "000";
    signal SelectOut : std_logic_vector(7 downto 0);

begin

    CLK <= not CLK after 5 us;

    Decoder: entity work.Decoder3bit
    port map (
        Disable => Disable,
        BitIn => BitIn,
        SelectOut => SelectOut
    );

    process is
    begin
        
        wait for 5 us;

        Disable <= '1';
        BitIn <= "010";

        wait for 10 us;

        Disable <= '0';

        testAllCombination : for i in 0 to 7 loop
            BitIn <= std_logic_vector(to_unsigned(i, BitIn'length));
            wait for 10 us;
        end loop ; -- testAllCombination

        Disable <= '1';
        wait for 10 us;

        wait;
    end process;

end TB ;