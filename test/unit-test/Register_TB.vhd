library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RegisterPlus_TB is
end entity;

architecture TB of RegisterPlus_TB is

    signal CLK : std_logic := '0';
    signal Load : std_logic := '0';
    signal Save : std_logic := '0';
    signal Save_Val : unsigned(7 downto 0) := "10101010";

    signal Fetch : unsigned(7 downto 0);
    signal Always : unsigned(7 downto 0);
begin

    CLK <= not CLK after 5 us;

    TestRegister: entity work.RegisterPlus
    port map (
        Load => Load,
        Save => Save,
        Save_Val => Save_Val,

        Fetch => Fetch,
        Always => Always
    );

    process is
    begin
        
        wait for 10 us;
        Load <= '1';
        wait for 10 us;

        Save <= '1';
        wait for 10 us;

        Load <= '0';
        Save <= '0';
        wait for 20 us;

        Load <= '1';
        wait for 10 us;

        Load <= '0';
        Save_Val <= "00001111";
        wait for 10 us;

        Save <= '1';
        wait for 10 us;
        Load <= '1';
        wait for 10 us;

        wait;
    end process;

end TB ;