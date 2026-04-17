library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

-- for now we follow the diagram i made for the game Turing Complete
-- this is definitely filled with issues
-- the main one being that it's just the CPU and not quite a whole Microcontroller
-- TODO : we'll be adding a RAM and a Flash to our design later (use the FPGA given one)
entity MCU is
  port (
    CLK : in std_logic;
    MCU_IN : in unsigned(7 downto 0);
    INSTRUCT : in unsigned(7 downto 0);

    PC : out unsigned(7 downto 0);
    MCU_OUT : out unsigned(7 downto 0)
  );
end MCU;

architecture IMPL of MCU is
    signal REG_BUS : unsigned(7 downto 0) := 0;
begin
    R0 : entity work.RegisterPlus;
    R1 : entity work.RegisterPlus;
    R2 : entity work.RegisterPlus;
    R3 : entity work.RegisterPlus;
    R4 : entity work.RegisterPlus;
    R5 : entity work.RegisterPlus;

    ALU_unit : entity work.ALU;
    Booling : entity work.BooleanUnit;

    DecodOP : entity work.OpcodeDecoder;
    DecodRead : entity work.Decoder3bit;
    DecodWrite : entity work.Decoder3bit;

    Counter : entity work.ProgramCounter;

end IMPL;