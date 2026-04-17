library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity ALU is
  port (
    Instruct : in unsigned(7 downto 0);  
    I1 : in unsigned(7 downto 0);
    I2 : in unsigned(7 downto 0);

    Res : out unsigned(7 downto 0)
  );
end ALU;

architecture IMPL of ALU is
begin

end IMPL;