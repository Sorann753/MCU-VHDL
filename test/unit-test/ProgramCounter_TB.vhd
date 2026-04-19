library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ProgramCounter_TB is
end entity;

architecture TB of ProgramCounter_TB is

    signal CLK : std_logic := '0';
    signal MODE : std_logic := '0';
    signal OVER_VAL : unsigned(7 downto 0) := "10101010";

    signal PC : unsigned(7 downto 0);
begin

    CLK <= not CLK after 5 us;

    counter: entity work.ProgramCounter
    port map (
        CLK => CLK,
        MODE => MODE,
        OVER_VAL => OVER_VAL,

        PC => PC
    );

    process is
    begin
        
        wait for 100 us;

        MODE <= '1';

        wait for 10 us;

        OVER_VAL <= "00001111";

        wait for 12 us;

        OVER_VAL <= "11110000";

        wait for 6 us;

        MODE <= '0';

        wait for 30 us;

        wait;
    end process;

end TB ;