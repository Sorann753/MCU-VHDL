library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

  -- for now we follow the diagram i made in the game Turing Complete
  -- this is definitely filled with issues
  -- the main one being that it's just the CPU and not quite a whole Microcontroller
  -- TODO : we'll be adding a RAM and a Flash to our design later (use the FPGA given one)

entity MCU is
  port (
    CLK      : in  std_logic;
    MCU_IN   : in  unsigned(7 downto 0);
    INSTRUCT : in  unsigned(7 downto 0);

    PC       : out unsigned(7 downto 0);
    MCU_OUT  : out unsigned(7 downto 0)
  );
end entity;

architecture IMPL of MCU is
  type unsigned_array_t is array (natural range <>) of unsigned(7 downto 0);

  signal REG_BUS_IN : unsigned(7 downto 0) := "00000000";
  signal REG_BUS_OUT : unsigned_array_t(0 to 5);

  signal R_Always : unsigned_array_t(0 to 3);

  signal BoolTrigg      : std_logic;
  signal CopyTrigg      : std_logic;
  signal CalcTrigg      : std_logic;
  signal ImmediateTrigg : std_logic;

  signal ReadChoice  : std_logic_vector(7 downto 0);
  signal WriteChoice : std_logic_vector(7 downto 0);

  signal BooleanRes : std_logic;
  signal CalcRes    : unsigned(7 downto 0);

  signal NULLVAL : unsigned(7 downto 0);
  --signal NULLLOG : std_logic := 'X';
begin
  R0: entity work.RegisterPlus
    port map (
      Load     => ReadChoice(0),
      Save     => WriteChoice(0),
      Save_Val => REG_BUS_IN,

      Fetch    => REG_BUS_OUT(0),
      Always   => R_Always(0)
    );
  R1: entity work.RegisterPlus
    port map (
      Load     => ReadChoice(1),
      Save     => WriteChoice(1),
      Save_Val => REG_BUS_IN,

      Fetch    => REG_BUS_OUT(1),
      Always   => R_Always(1)
    );
  R2: entity work.RegisterPlus
    port map (
      Load     => ReadChoice(2),
      Save     => WriteChoice(2),
      Save_Val => REG_BUS_IN,

      Fetch    => REG_BUS_OUT(2),
      Always   => R_Always(2)
    );
  R3: entity work.RegisterPlus
    port map (
      Load     => ReadChoice(3),
      Save     => (WriteChoice(3) or CalcTrigg),
      Save_Val => REG_BUS_IN,

      Fetch    => REG_BUS_OUT(3),
      Always   => R_Always(3)
    );
  R4: entity work.RegisterPlus
    port map (
      Load     => ReadChoice(4),
      Save     => WriteChoice(4),
      Save_Val => REG_BUS_IN,

      Fetch    => REG_BUS_OUT(4),
      Always   => NULLVAL --unused port
    );
  R5: entity work.RegisterPlus
    port map (
      Load     => ReadChoice(5),
      Save     => WriteChoice(5),
      Save_Val => REG_BUS_IN,

      Fetch    => REG_BUS_OUT(5),
      Always   => NULLVAL --unused port
    );

  ALU_unit: entity work.ALU
    port map (
      INSTRUCT => INSTRUCT,
      I1       => R_Always(1),
      I2       => R_Always(2),

      Res      => CalcRes
    );

  Booling: entity work.BooleanUnit
    port map (
      Cond  => INSTRUCT,
      Value => signed(R_Always(3)),

      R     => BooleanRes
    );

  DecodOP: entity work.OpcodeDecoder
    port map (
      OPCODE    => INSTRUCT,

      Immediate => ImmediateTrigg,
      Calculate => CalcTrigg,
      Copy      => CopyTrigg,
      Cond      => BoolTrigg
    );

  DecodRead: entity work.Decoder3bit
    port map (
      Disable   => (not CopyTrigg),
      BitIn     => (INSTRUCT(5) & INSTRUCT(4) & INSTRUCT(3) ),

      SelectOut => ReadChoice
    );

  DecodWrite: entity work.Decoder3bit
    port map (
      Disable   => (not CopyTrigg),
      BitIn     => (INSTRUCT(2) & INSTRUCT(1) & INSTRUCT(0)),

      SelectOut => WriteChoice
    );

  Counter: entity work.ProgramCounter
    port map (
      CLK      => CLK,
      MODE     => (BooleanRes and BoolTrigg),
      OVER_VAL => R_Always(0),

      PC       => PC
    );



  process (CLK)
  begin
    if (rising_edge(CLK)) then
      -- clocked events
    end if;
  end process;

  process (WriteChoice(6))
  begin
    if (WriteChoice(6) = '1') then
      MCU_OUT <= REG_BUS_IN;
    else
      MCU_OUT <= to_unsigned(0, 8);
    end if;
  end process;

  process (CLK, ReadChoice, CalcTrigg, ImmediateTrigg)
  begin
    if(rising_edge(CLK)) then
      REG_BUS_IN <= REG_BUS_OUT(0) when ReadChoice(0) = '1' else
                    REG_BUS_OUT(1) when ReadChoice(1) = '1' else
                    REG_BUS_OUT(2) when ReadChoice(2) = '1' else
                    REG_BUS_OUT(3) when ReadChoice(3) = '1' else
                    REG_BUS_OUT(4) when ReadChoice(4) = '1' else
                    REG_BUS_OUT(5) when ReadChoice(5) = '1' else
                    MCU_IN when ReadChoice(6) = '1' else
                    CalcRes when CalcTrigg = '1' else
                    INSTRUCT when ImmediateTrigg = '1';
    end if;
  end process;
end architecture;
