library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity MCU8b_TB is
end entity;

architecture TB of MCU8b_TB is

  signal CLK      : std_logic            := '0';
  signal MCU_IN   : unsigned(7 downto 0) := to_unsigned(0, 8);
  signal INSTRUCT : unsigned(7 downto 0) := to_unsigned(0, 8);

  signal PC      : unsigned(7 downto 0);
  signal MCU_OUT : unsigned(7 downto 0);

  procedure run_instruct(
      constant instruction : in unsigned(7 downto 0);
      signal target : out unsigned(7 downto 0)
    ) is
  begin
    target <= instruction;
    wait for 5 us;
  end procedure;
begin

  CLK <= not CLK after 5 us;

  TestMCU: entity work.MCU
    port map (
      CLK      => CLK,
      MCU_IN   => MCU_IN,
      INSTRUCT => INSTRUCT,

      PC       => PC,
      MCU_OUT  => MCU_OUT
    );

  process is
  begin

    wait for 10 us;

    MCU_IN <= to_unsigned(0, 8);
    run_instruct("10110001", INSTRUCT); -- MOV Rin R1
    MCU_IN <= to_unsigned(1, 8);
    run_instruct("10110010", INSTRUCT); -- MOV Rin R2

    fib_loop : for i in 0 to 13 loop
        run_instruct("01000100", INSTRUCT); -- ADD

        run_instruct("10011110", INSTRUCT); -- MOV R3 Rout

        run_instruct("10010001", INSTRUCT); -- MOV R2 R1
        run_instruct("10011010", INSTRUCT); -- MOV R3 R2
    end loop ; -- fib_loop
    
    wait for 10 us;
    
    wait;
  end process;
end architecture;
