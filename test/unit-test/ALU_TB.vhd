library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity ALU_TB is
end entity;

-- TODO : make more extensive test later but for now this seems enough

architecture TB of ALU_TB is

  signal CLK      : std_logic            := '0';
  signal Instruct : unsigned(7 downto 0) := "00000000";
  signal I1       : unsigned(7 downto 0) := "00000000";
  signal I2       : unsigned(7 downto 0) := "00000000";

  signal Res    : unsigned(7 downto 0);
  signal expect : unsigned(7 downto 0) := "00000000";
begin

  CLK <= not CLK after 5 us;

  TestALU: entity work.ALU
    port map (
      Instruct => Instruct,
      I1       => I1,
      I2       => I2,

      Res      => Res
    );

  process is
  begin

    wait for 10 us;

    -- test OR
    I1 <= "10101010";
    expect <= "10101010";
    wait for 5 us;
    I2 <= "01010101";
    expect <= "11111111";
    wait for 5 us;

    -- test NAND
    I1 <= "11110000";
    I2 <= "10101010";
    Instruct <= "00000001";
    expect <= "01011111";
    wait for 5 us;

    -- test NOR
    Instruct <= "00000010";
    expect <= "00000101";
    wait for 5 us;

    -- test AND
    Instruct <= "00000011";
    expect <= "10100000";
    wait for 5 us;

    -- test ADD
    Instruct <= "00000100";
    I1 <= to_unsigned(4, 8);
    I2 <= to_unsigned(25, 8);
    expect <= to_unsigned(29, 8);
    wait for 5 us;

    -- test Subtract
    I1 <= to_unsigned(90, 8);
    I2 <= to_unsigned(100, 8);
    Instruct <= "00000101";
    expect <= unsigned(to_signed(- 10, 8));
    wait for 5 us;
    I1 <= to_unsigned(100, 8);
    I2 <= to_unsigned(90, 8);
    expect <= to_unsigned(10, 8);
    wait for 5 us;

    wait;
  end process;
end architecture;
