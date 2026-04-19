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
  type ope_t is (OP_NAND, OP_AND, OP_OR, OP_NOR, OP_ADD, OP_SUB);
  signal operation : ope_t := OP_OR;
begin

  process(Instruct)
    variable bitCode: unsigned(7 downto 0);
  begin
    bitCode := Instruct and "00000111";

    case(bitCode) is
      when "00000000" =>
        operation <= OP_OR;
      when "00000001" =>
        operation <= OP_NAND;
      when "00000010" =>
        operation <= OP_NOR;
      when "00000011" =>
        operation <= OP_AND;
      when "00000100" =>
        operation <= OP_ADD;
      when "00000101" =>
        operation <= OP_SUB;
        
      -- in case i messed up my mask
      when others =>
        operation <= OP_OR;
    end case;
  end process;



  process(operation, I1, I2)
  begin
    case(operation) is
      when OP_OR =>
        Res <= I1 or I2;
      when OP_NAND =>
        Res <= I1 nand I2;
      when OP_NOR =>
        Res <= I1 nor I2;
      when OP_AND =>
        Res <= I1 and I2;
      when OP_ADD =>
        Res <= I1 + I2;
      when OP_SUB =>
        Res <= I1 - I2;
        
    
      -- unimplemented operation
      when others =>
        Res <= to_unsigned(0, 8);
    end case ;
  end process;

end IMPL;
