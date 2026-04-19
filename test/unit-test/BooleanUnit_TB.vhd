library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity BooleanUnit_TB is
end entity;

architecture TB of BooleanUnit_TB is

    signal CLK : std_logic := '0';
    signal Cond : unsigned(7 downto 0) := "00000000";
    signal Value : signed(7 downto 0) := "00000000";

    signal R : std_logic;
    signal expect : std_logic := '0';
begin

    CLK <= not CLK after 5 us;

    TestBoolUnit: entity work.BooleanUnit
    port map (
        Cond => Cond,
        Value => Value,

        R => R
    );

    -- TODO : improve the test case to verify explicitly all possible input
    process is
    begin
        -- test false
        wait for 10 us;
        Cond <= to_unsigned(31, 5) & "000";
        expect <= '0';
        wait for 5 us;

        -- test equality
        Cond <= "00000001";
        expect <= '1';
        wait for 5 us;
        Value <= to_signed(45, 8);
        expect <= '0';
        wait for 5 us;

        -- test lesser than 0
        Cond <= "00000010";
        expect <= '0';
        wait for 5 us;
        Value <= "10010111";
        expect <= '1';
        wait for 5 us;
        
        -- test less or eq
        Cond <= "00000011";
        expect <= '1';
        wait for 5 us;
        Value <= to_signed(21, 8);
        expect <= '0';
        wait for 5 us;
        Value <= "00000000";
        expect <= '1';
        wait for 5 us;
        
        -- test Greater than 0
        Cond <= "00000111";
        expect <= '0';
        wait for 5 us;
        Value <= to_signed(21, 8);
        expect <= '1';
        wait for 5 us;
        Value <= to_signed(-112, 8);
        expect <= '0';
        wait for 5 us;

        -- test True
        Cond <= "00000100";
        expect <= '1';
        wait for 5 us;

        -- test Greater or equal
        Cond <= "00000110";
        expect <= '0';
        wait for 5 us;
        Value <= to_signed(17, 8);
        expect <= '1';
        wait for 5 us;
        Value <= to_signed(-17, 8);
        expect <= '0';
        wait for 5 us;
        Value <= to_signed(0, 8);
        expect <= '1';
        wait for 5 us;

        -- test not equal
        Cond <= "00000101";
        expect <= '0';
        wait for 5 us;
        Value <= to_signed(119, 8);
        expect <= '1';
        wait for 5 us;
        Value <= to_signed(-120, 8);
        expect <= '1';
        wait for 5 us;

        wait;
    end process;
end TB ;