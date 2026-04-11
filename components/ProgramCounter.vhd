library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity ProgramCounter is
  port (
    CLK      : in  std_logic;
    MODE     : in  std_logic;
    OVER_VAL : in  unsigned(7 downto 0);

    PC       : out unsigned(7 downto 0) := "00000000"
  );
end entity;

architecture IMPL of ProgramCounter is
  signal NEXT_PC : unsigned(7 downto 0);
begin

  process (CLK)
  begin
    if rising_edge(CLK) then
      PC <= NEXT_PC;
    end if;
  end process;

  process (PC, MODE, OVER_VAL)
  begin
    if MODE = '1' then
      NEXT_PC <= OVER_VAL;
    elsif MODE = '0' then
      NEXT_PC <= PC + 1;
    end if;
  end process;

end architecture;
