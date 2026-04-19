library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity OpcodeDecoder_TB is
end entity;

architecture TB of OpcodeDecoder_TB is

    signal CLK : std_logic := '0';
    signal OPCODE : unsigned(7 downto 0) := to_unsigned(0, 8);

    signal Immediate : std_logic;
    signal Calculate : std_logic;
    signal Copy : std_logic;
    signal Cond : std_logic;
begin

    CLK <= not CLK after 5 us;

    TestDecoder: entity work.OpcodeDecoder
    port map (
        OPCODE => OPCODE,

        Immediate => Immediate,
        Calculate => Calculate,
        Copy => Copy,
        Cond => Cond
    );

    process is
    begin
        
        wait for 10 us;
        OPCODE <= "01000000";
        wait for 10 us;
        OPCODE <= "10000000";
        wait for 10 us;
        OPCODE <= "11000000";
        wait for 10 us;

        for i in 0 to 255 loop
            OPCODE <= to_unsigned(i, 8);
            wait for 5 us;
        end loop;

        OPCODE <= to_unsigned(0, 8);
        wait for 10 us;

        wait;
    end process;

end TB ;