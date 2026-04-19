library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity BooleanUnit is
  port (
    Cond : in unsigned(7 downto 0);
    Value : in signed(7 downto 0);

    R : out std_logic := '0'
  );
end BooleanUnit;

architecture IMPL of BooleanUnit is
    type cond_t is (T, F, C_EQ, NEQ, LS, LEQ, GR, GEQ);
    signal comp : cond_t := F;
begin

    -- This is mainly a utility process to make it easier
    -- to add or change conditions later
    process(Cond)
        variable choiceBit : unsigned(7 downto 0);
    begin
        choiceBit := Cond and "00000111";

        case(choiceBit) is
            when "00000000" =>
                comp <= F;
            when "00000001" =>
                comp <= C_EQ;
            when "00000010" =>
                comp <= LS;
            when "00000011" =>
                comp <= LEQ;

            -- inverted cases
            when "00000100" =>
                comp <= T;
            when "00000101" =>
                comp <= NEQ;
            when "00000110" =>
                comp <= GEQ;
            when "00000111" =>
                comp <= GR;
        
            -- if we messed up our masking
            when others =>
                comp <= F;
        end case ;
    end process;



    process(comp, Value)
    begin
        case(comp) is
            when T =>
                R <= '1';
            when F =>
                R <= '0';
            when C_EQ =>
                R <= '1' when (Value = 0) else '0';
            when NEQ =>
                R <= '1' when (Value /= 0) else '0';
            when LS =>
                R <= '1' when (Value < 0) else '0';
            when LEQ =>
                R <= '1' when (Value <= 0) else '0';
            when GR =>
                R <= '1' when (Value > 0) else '0';
            when GEQ =>
                R <= '1' when (Value >= 0) else '0';
        
            -- weird case
            when others =>
                R <= '0';
        end case ;
    end process;

end IMPL;